// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {ERC6551Implementation} from "../../src/blockMonster/ERC6551Implementation.sol";

contract ERC6551ImplementationScript is Script {
    ERC6551Implementation mainContract;

    function setUp() public {}

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        mainContract = new ERC6551Implementation();

        vm.stopBroadcast();
    }
}
