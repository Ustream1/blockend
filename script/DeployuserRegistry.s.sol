// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {UserRegistry} from "../src/UserRegistry.sol";

contract DeployUserRegistry is Script {
    function run() external returns (UserRegistry) {
        vm.startBroadcast();
        UserRegistry userRegistry = new UserRegistry();
        vm.stopBroadcast();
        return userRegistry;
    }
}
