// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {CreatorRegistry} from "../src/CreatorRegistry.sol";

contract DeployCreatorRegistry is Script {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    
    function run() external returns (CreatorRegistry) {
        vm.startBroadcast(deployerPrivateKey);
        CreatorRegistry creatorRegistry = new CreatorRegistry();
        vm.stopBroadcast();
        return creatorRegistry;
    }
}
