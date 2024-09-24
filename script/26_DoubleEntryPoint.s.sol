// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {DoubleEntryPoint, LegacyToken, Forta} from "../src/26_DoubleEntryPoint.sol";
import {Script, console} from "forge-std/Script.sol";

contract DoubleEntryPointSolve is Script {
    DoubleEntryPoint entryPoint = DoubleEntryPoint(0xb0e9bedfBd80819B4c6888d9AA8d351D5DEfE4AC);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        address player = entryPoint.player();
        address legacyToken = entryPoint.delegatedFrom();
        console.log("player# ", player);
        console.log("LegacyToken#", legacyToken);
        console.log(address(LegacyToken(legacyToken).delegate()));
        console.log("entryPoint# ", address(entryPoint));

        Forta forta = entryPoint.forta();
        DetectionBot detectionBot = new DetectionBot();
        forta.setDetectionBot(address(detectionBot));

        vm.stopBroadcast();
    }
}

contract DetectionBot {
    DoubleEntryPoint entryPoint = DoubleEntryPoint(0xb0e9bedfBd80819B4c6888d9AA8d351D5DEfE4AC);
    address cryptoVault = entryPoint.cryptoVault();

    function handleTransaction(address user, bytes calldata msgData) public {
        (address to, uint256 value, address origSender) = abi.decode(msgData[4:], (address, uint256, address));

        if (origSender == cryptoVault) {
            Forta(msg.sender).raiseAlert(user);
        }
    }
}
