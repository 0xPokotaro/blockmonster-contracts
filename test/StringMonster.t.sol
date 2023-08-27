// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {console2} from "forge-std/console2.sol";
import {Test} from "forge-std/Test.sol";
import {EvolutionStone} from "../src/EvolutionStone.sol";
import {ERC6551Implementation} from "../src/ERC6551Implementation.sol";
import {ERC6551Registry} from "../src/ERC6551Registry.sol";
import {StringMonster} from "../src/StringMonster.sol";

contract StringMonsterTest is Test {
    EvolutionStone public evolutionStoneContract;

    ERC6551Implementation public implementContract;
    ERC6551Registry public registryContract;
    StringMonster public stringMonsterContract;

    address public owner = address(0x34A1D3fff3958843C43aD80F30b94c510645C316);

    function setUp() public {
        evolutionStoneContract = new EvolutionStone();

        registryContract = new ERC6551Registry();
        implementContract = new ERC6551Implementation();
        stringMonsterContract = new StringMonster(address(implementContract), address(registryContract), address(evolutionStoneContract));

        stringMonsterContract.setMonsterType(1, "Grass", "#4CAF50", "Forest", "#2E7D32");
        stringMonsterContract.setMonsterType(2, "Fire", "#FF5722", "Inferno", "#D84315");
        stringMonsterContract.setMonsterType(3, "Water", "#2196F3", "Ocean", "#1565C0");
        stringMonsterContract.setMonsterType(4, "Earth", "#9E9E9E", "Mountain", "#616161");
        stringMonsterContract.setMonsterType(5, "Wind", "#81D4FA", "Storm", "#29B6F6");
        stringMonsterContract.setMonsterType(6, "Electric", "#FFEB3B", "Lightning", "#FBC02D");
        stringMonsterContract.setMonsterType(7, "Ice", "#B3E5FC", "Glacier", "#81D4FA");
        stringMonsterContract.setMonsterType(8, "Metal", "#B0BEC5", "Alloy", "#78909C");
        stringMonsterContract.setMonsterType(9, "Dark", "#212121", "Abyss", "#000000");
        stringMonsterContract.setMonsterType(10, "Light", "#FFF59D", "Radiance", "#FFEE58");

        stringMonsterContract.mint(1, 1);
        evolutionStoneContract.mint(1);

        evolutionStoneContract.approve(address(stringMonsterContract), 1);
        evolutionStoneContract.transferFrom(owner, stringMonsterContract.getAccount(1), 1);
    }

    function testDebug() public {
        // uint256 randomNum = stringMonsterContract.randonNum(361, block.prevrandao, 100);
        // console2.log(randomNum);
        console2.log(stringMonsterContract.tokenURI(1));
        assertEq(stringMonsterContract.name(), "StringMonster");
    }
}
