// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {console2} from "forge-std/console2.sol";
import {Test} from "forge-std/Test.sol";
import {EvolutionStone} from "../src/EvolutionStone.sol";
import {ERC6551Implementation} from "../src/blockMonster/ERC6551Implementation.sol";
import {ERC6551Registry} from "../src/blockMonster/ERC6551Registry.sol";
import {BlockMonster} from "../src/blockMonster/BlockMonster.sol";

contract BlockMonsterTest is Test {
    EvolutionStone public evolutionStoneContract;

    ERC6551Implementation public implementContract;
    ERC6551Registry public registryContract;
    BlockMonster public mainContract;

    address owner = address(0x34A1D3fff3958843C43aD80F30b94c510645C316);
    address alice = address(0x1889);
    address bob = address(0x1778);

    function setUp() public {
        vm.startPrank(owner);
        evolutionStoneContract = new EvolutionStone();

        registryContract = new ERC6551Registry();
        implementContract = new ERC6551Implementation();
        mainContract = new BlockMonster(address(implementContract), address(registryContract), address(evolutionStoneContract));

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

        mainContract.mint(1, 1);
        evolutionStoneContract.mint(1);

        evolutionStoneContract.approve(address(mainContract), 1);
        evolutionStoneContract.transferFrom(owner, mainContract.getAccount(1), 1);
         vm.stopPrank();
    }

    function debug() public {
        // uint256 randomNum = stringMonsterContract.randonNum(361, block.prevrandao, 100);
        // console2.log(randomNum);
        // console2.log(stringMonsterContract.tokenURI(1));
        // assertEq(stringMonsterContract.name(), "StringMonster");
    }

    function test_SetMonsterType() public {
        uint256 newMonsterType = 11;
        string memory newBType = "Hoge";
        string memory newBColor = "#FFFFFF";
        string memory newAType = "Huga";
        string memory newAColor = "#000000";

        mainContract.setMonsterType(newMonsterType, newBType, newBColor, newAType, newAColor);

        (string memory bType, string memory bColor, string memory aType, string memory aColor) = mainContract.monsterTypes(newMonsterType);

        assertEq(bType, newBType);
        assertEq(bColor, newBColor);
        assertEq(aType, newAType);
        assertEq(aColor, newAColor);
    }

    /*
    function testFail_SetMonsterType() public {
        uint256 newMonsterType = 11;
        string memory newBType = "Hoge";
        string memory newBColor = "#FFFFFF";
        string memory newAType = "Huga";
        string memory newAColor = "#000000";

        vm.prank(address(0));
        vm.expectRevert("Ownable: caller is not the owner");
        mainContract.setMonsterType(newMonsterType, newBType, newBColor, newAType, newAColor);
    }
    */

    function test_GetIsEvolution() public {
        assertEq(mainContract.getIsEvolution(1), true);

        mainContract.mint(1, 1);
        assertEq(mainContract.getIsEvolution(2), false);
    }

    function test_GetMonsterType() public {
        uint256 tokneId = 1;
        assertEq(mainContract.getMonsterType(tokneId), "Grass");
    }

    function test_GetMonsterColor() public {
        uint256 tokneId = 1;
        assertEq(mainContract.getMonsterColor(tokneId), "#4CAF50");
    }
}
