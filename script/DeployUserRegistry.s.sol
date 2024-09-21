// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {UserRegistry} from "../src/UserRegistry.sol";

contract DeployUserRegistry is Script {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    
    function run() external returns (UserRegistry) {
        vm.startBroadcast(deployerPrivateKey);
        UserRegistry userRegistry = new UserRegistry();
        vm.stopBroadcast();
        return userRegistry;
    }
}
