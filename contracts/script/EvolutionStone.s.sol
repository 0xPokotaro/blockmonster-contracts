// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {console2} from "forge-std/console2.sol";
import {Script} from "forge-std/Script.sol";
import {EvolutionStone} from "../src/EvolutionStone.sol";

contract EvolutionStoneScript is Script {
    EvolutionStone mainContract;

    function setUp() public {}

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        mainContract = new EvolutionStone();

        mainContract.mint(10);

        vm.stopBroadcast();
    }
}
