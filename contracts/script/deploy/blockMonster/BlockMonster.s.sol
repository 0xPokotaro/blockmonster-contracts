// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {console2} from "forge-std/console2.sol";
import {Script} from "forge-std/Script.sol";
import {BlockMonster} from "../../../src/blockMonster/BlockMonster.sol";

contract BlockMonsterScript is Script {
    BlockMonster mainContract;

    address implementation = 0xC1Af53a83Af5feB946F1C7ca4a90d2C16D0D9c8c;
    address registry = 0x42735056E2173C1f4eA24d8753169724FC1685Ab;
    address evolutionStone = 0x761691FBC93f7A2BcFb2ef700B53bd4C3C93Fc73;

    function setUp() public {}

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        mainContract = new BlockMonster(implementation, registry, evolutionStone);

        mainContract.setMonsterType(1, "Grass", "#4CAF50", "Forest", "#2E7D32");
        mainContract.setMonsterType(2, "Fire", "#FF5722", "Inferno", "#D84315");
        mainContract.setMonsterType(3, "Water", "#2196F3", "Ocean", "#1565C0");
        // mainContract.setMonsterType(4, "Earth", "#9E9E9E", "Mountain", "#616161");
        // mainContract.setMonsterType(5, "Wind", "#81D4FA", "Storm", "#29B6F6");

        vm.stopBroadcast();
    }
}
