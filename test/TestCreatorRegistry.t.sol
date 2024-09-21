// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console2} from "forge-std/Test.sol";
import {CreatorRegistry} from "../src/CreatorRegistry.sol";

contract TestCreatorRegistry is Test {
    CreatorRegistry creatorRegistry;

    address Alice;
    address Bob;
    address Clara;

    address Admin;
    address zeroAddr;

    function setUp() public {
        creatorRegistry = new CreatorRegistry();

        Alice = makeAddr("Alice");
        Bob = makeAddr("Bob");
        Clara = makeAddr("Clara");
        Admin = makeAddr("Admin");

        zeroAddr = address(0);

        creatorRegistry.setAdmin(Admin);
    }

    function testConstructor() public view {
        assert(creatorRegistry.getCreatorCount() == 0);
    }

    function testSetUp() public view {
        assert(creatorRegistry.getAdmin() == Admin);
    }

    function testAdminCanAddCreator() public {
        vm.prank(Admin);
        creatorRegistry.addCreator(Alice);

        assert(creatorRegistry.getCreatorCount() == 1);
        assert(creatorRegistry.getCreatorStatus(Alice) == true);
    }

    function testAdminCanRemoveCreator() public {
        vm.prank(Admin);
        creatorRegistry.addCreator(Alice);

        assert(creatorRegistry.getCreatorCount() == 1);
        assert(creatorRegistry.getCreatorStatus(Alice) == true);

        vm.prank(Admin);
        creatorRegistry.removeCreator(Alice);
        assert(creatorRegistry.getCreatorCount() == 0);
        assert(creatorRegistry.getCreatorStatus(Alice) == false);
    }

    function testSetAdmin() public {
        vm.prank(Admin);
        creatorRegistry.setAdmin(Alice);

        assert(creatorRegistry.getAdmin() != Admin);
        assert(creatorRegistry.getAdmin() == Alice);
    }

    function testCanGetCreatorList() public {
        address[] memory intialCreatorList = creatorRegistry.getCreatorList();
        assert(intialCreatorList.length == 0);

        vm.startPrank(Admin);
        creatorRegistry.addCreator(Alice);
        creatorRegistry.addCreator(Bob);
        creatorRegistry.addCreator(Clara);
        vm.stopPrank();

        assert(creatorRegistry.getCreatorCount() == 3);
        assert(creatorRegistry.getCreatorStatus(Alice) == true);
        assert(creatorRegistry.getCreatorStatus(Bob) == true);
        assert(creatorRegistry.getCreatorStatus(Clara) == true);

        address[] memory finalCreatorList = creatorRegistry.getCreatorList();
        assert(finalCreatorList.length == 3);
    }
}
