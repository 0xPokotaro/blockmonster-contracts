// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {ERC6551Registry} from "../../../src/blockMonster/ERC6551Registry.sol";

contract ERC6551RegistryScript is Script {
    ERC6551Registry mainContract;

    function setUp() public {}

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        mainContract = new ERC6551Registry();

        vm.stopBroadcast();
    }
}
