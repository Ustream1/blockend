// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {StreamToken} from "../src/StreamToken.sol";

contract DeployStreamToken is Script {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

    function run() external returns (StreamToken) {
        vm.startBroadcast(deployerPrivateKey);
        StreamToken token = new StreamToken();
        vm.stopBroadcast();
        return token;
    }
}
