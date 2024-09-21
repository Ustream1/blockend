// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {StreamToken} from "../src/StreamToken.sol";

contract DeployStreamToken is Script {
    function run() external returns (StreamToken) {
        vm.startBroadcast();
        StreamToken token = new StreamToken();
        vm.stopBroadcast();
        return token;
    }
}
