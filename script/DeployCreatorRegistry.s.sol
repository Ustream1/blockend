// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {CreatorRegistry} from "../src/CreatorRegistry.sol";

contract DeployCreatorRegistry is Script {
    function run() external returns (CreatorRegistry) {
        vm.startBroadcast();
        CreatorRegistry creatorRegistry = new CreatorRegistry();
        vm.stopBroadcast();
        return creatorRegistry;
    }
}
