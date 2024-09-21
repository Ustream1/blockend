// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console2} from "forge-std/Test.sol";
import {UserRegistry} from "../src/UserRegistry.sol";

contract TestUserRegistry is Test {
    UserRegistry userRegistry;

    address Alice;
    address Bob;
    address Clara;

    address Admin;
    address zeroAddr;

    function setUp() public {
        userRegistry = new UserRegistry();

        Alice = makeAddr("Alice");
        Bob = makeAddr("Bob");
        Clara = makeAddr("Clara");
        Admin = makeAddr("Admin");

        zeroAddr = address(0);

        userRegistry.setAdmin(Admin);
    }

    function testConstructor() public view {
        console2.log(zeroAddr);
        assert(userRegistry.getUserCount() == 0);
        assert(userRegistry.getAdmin() == Admin);
    }

    function testSetUp() public view {
        assert(userRegistry.getAdmin() == Admin);
    }

    function testBecomeUser() public {
        vm.prank(Alice);
        userRegistry.becomeUser();

        assert(userRegistry.getUserCount() == 1);
        assert(userRegistry.getUserStatus(Alice) == true);
    }

    function testLeaveProtocol() public {
        vm.prank(Alice);
        userRegistry.becomeUser();

        assert(userRegistry.getUserCount() == 1);
        assert(userRegistry.getUserStatus(Alice) == true);

        vm.prank(Alice);
        userRegistry.leaveProtocol();

        assert(userRegistry.getUserCount() == 0);
        assert(userRegistry.getUserStatus(Alice) == false);
    }

    function testRemoveUser() public {
        vm.prank(Bob);
        userRegistry.becomeUser();

        assert(userRegistry.getUserCount() == 1);
        assert(userRegistry.getUserStatus(Bob) == true);

        vm.prank(Clara);
        userRegistry.becomeUser();

        assert(userRegistry.getUserCount() == 2);
        assert(userRegistry.getUserStatus(Clara) == true);

        vm.prank(Admin);
        userRegistry.removeUser(Bob);

        assert(userRegistry.getUserCount() == 1);
        assert(userRegistry.getUserStatus(Bob) == false);
        assert(userRegistry.getUserStatus(Clara) == true);
    }

    function testSetAdmin() public {
        vm.prank(Admin);
        userRegistry.setAdmin(Alice);

        assert(userRegistry.getAdmin() == Alice);
        assert(userRegistry.getAdmin() != Admin);
    }

    function testExpectedReverts() public {
        vm.prank(Alice);
        userRegistry.becomeUser();

        vm.prank(Alice);
        vm.expectRevert(UserRegistry.UR__UserExist.selector);
        userRegistry.becomeUser();

        vm.prank(Bob);
        vm.expectRevert(UserRegistry.UR__UserDoesntExist.selector);
        userRegistry.leaveProtocol();

        vm.prank(Bob);
        vm.expectRevert(UserRegistry.UR__NotAdmin.selector);
        userRegistry.removeUser(Alice);

        vm.prank(Clara);
        vm.expectRevert(UserRegistry.UR__NotAdmin.selector);
        userRegistry.setAdmin(Clara);

        vm.prank(Admin);
        vm.expectRevert(UserRegistry.UR__CantBeZeroAddress.selector);
        userRegistry.setAdmin(address(0));

        vm.prank(Admin);
        vm.expectRevert(UserRegistry.UR__CantBeZeroAddress.selector);
        userRegistry.removeUser(zeroAddr);
    }
}
