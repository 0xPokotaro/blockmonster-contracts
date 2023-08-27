// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {console2} from "forge-std/console2.sol";
import {Script} from "forge-std/Script.sol";
import {StringMonster} from "../src/StringMonster.sol";

contract StringMonsterScript is Script {
    StringMonster mainContract;

    address implementation = 0x12b6E8ACFe89799c068e272cBE8139E6D9c5a8C9;
    address registry = 0xeca93cb5Fa0D0b7CbB22C01941aa3f3cab89a9d3;
    address evolutionStone = 0x3a594014eC81C9B650864b2CB8a38995Cd842421;

    function setUp() public {}

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        mainContract = new StringMonster(implementation, registry, evolutionStone);

        mainContract.setMonsterType(1, "Grass", "#4CAF50", "Forest", "#2E7D32");
        mainContract.setMonsterType(2, "Fire", "#FF5722", "Inferno", "#D84315");
        mainContract.setMonsterType(3, "Water", "#2196F3", "Ocean", "#1565C0");
        mainContract.setMonsterType(4, "Earth", "#9E9E9E", "Mountain", "#616161");
        mainContract.setMonsterType(5, "Wind", "#81D4FA", "Storm", "#29B6F6");
        mainContract.setMonsterType(6, "Electric", "#FFEB3B", "Lightning", "#FBC02D");
        mainContract.setMonsterType(7, "Ice", "#B3E5FC", "Glacier", "#81D4FA");
        mainContract.setMonsterType(8, "Metal", "#B0BEC5", "Alloy", "#78909C");
        mainContract.setMonsterType(9, "Dark", "#212121", "Abyss", "#000000");
        mainContract.setMonsterType(10, "Light", "#FFF59D", "Radiance", "#FFEE58");

        vm.stopBroadcast();
    }
}
