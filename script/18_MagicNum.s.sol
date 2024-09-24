// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {MagicNum} from "../src/18_MagicNum.sol";
import {Script, console} from "forge-std/Script.sol";

contract MagicNumSolve is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Attack().exploit();
        vm.stopBroadcast();
    }
}

contract Attack {
    MagicNum magicNum = MagicNum(0xefcc536c3FD85E06AF2D7132c870Bfe16e8Ab0D8);

    function exploit() public {
        bytes memory bytecode = hex"69602a60005260206000f3600052600a6016f3";
        address _solver;

        assembly {
            _solver := create(0, add(bytecode, 0x20), 0x13)
        }

        (, bytes memory data) = _solver.call("");
        require(bytes32(data) == bytes32(uint256(42)));

        magicNum.setSolver(_solver);
    }
}
