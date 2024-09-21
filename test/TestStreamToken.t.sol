// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console2} from "forge-std/Test.sol";
import {StreamToken} from "../src/StreamToken.sol";
import {DeployStreamToken} from "../script/DeployStreamToken.s.sol";

contract TestStreamToken is Test {
    StreamToken token;
    DeployStreamToken deployer;

    address Alice;

    function setUp() public {
        deployer = new DeployStreamToken();
        token = deployer.run();

        Alice = makeAddr("Alice");
    }

    function testConstructor() public view {
        assertEq(token.name(), "Stream Token");
        assertEq(token.symbol(), "STRK");
    }

    function testCanMint() public {
        token.mint(Alice, 100e18);

        assert(token.balanceOf(Alice) == 100e18);
    }
}
