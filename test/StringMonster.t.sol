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

    function setUp() public {
        evolutionStoneContract = new EvolutionStone();

        registryContract = new ERC6551Registry();
        implementContract = new ERC6551Implementation();
        stringMonsterContract = new StringMonster(address(implementContract), address(registryContract), address(evolutionStoneContract));
    }

    function testDebug() public {
        // uint256 randomNum = stringMonsterContract.randonNum(361, block.prevrandao, 100);
        // console2.log(randomNum);
        assertEq(stringMonsterContract.name(), "StringMonster");
    }
}
