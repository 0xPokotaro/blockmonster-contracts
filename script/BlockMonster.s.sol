// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {console2} from "forge-std/console2.sol";
import {Script} from "forge-std/Script.sol";
import {BlockMonster} from "../src/BlockMonster.sol";

contract BlockMonsterScript is Script {
    BlockMonster mainContract;

    address implementation = 0x12b6E8ACFe89799c068e272cBE8139E6D9c5a8C9;
    address registry = 0xeca93cb5Fa0D0b7CbB22C01941aa3f3cab89a9d3;
    address evolutionStone = 0x3a594014eC81C9B650864b2CB8a38995Cd842421;

    function setUp() public {}

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        mainContract = new BlockMonster(implementation, registry, evolutionStone);

        mainContract.setMonsterType(1, "Fire", "#F08030");
        mainContract.setMonsterType(2, "Water", "#6890F0");
        mainContract.setMonsterType(3, "Grass", "#78C850");
        mainContract.setMonsterType(4, "Normal", "#A8A878");
        mainContract.setMonsterType(5, "Electric", "#F8D030");
        mainContract.setMonsterType(6, "Ice", "#98D8D8");
        mainContract.setMonsterType(7, "Psychic", "#F85888");
        mainContract.setMonsterType(8, "Fighting", "#C03028");
        mainContract.setMonsterType(9, "Poison", "#A040A0");

        vm.stopBroadcast();
    }
}
