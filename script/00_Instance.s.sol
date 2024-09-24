// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Instance} from "../src/00_Instance.sol";
import {Script, console} from "forge-std/Script.sol";

contract InstanceSolve is Script {
    Instance instance = Instance(0x65fAabcE73ea03392692E23f6FE16726adD0D881);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        string memory passkey = instance.password();
        console.log("Passkey#", passkey);
        instance.authenticate(passkey);

        vm.stopBroadcast();
    }
}
