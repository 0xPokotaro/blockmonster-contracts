// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {console2} from "forge-std/console2.sol";
import {Test} from "forge-std/Test.sol";
import {EvolutionStone} from "../src/EvolutionStone.sol";
import {ERC6551Implementation} from "../src/blockMonster/ERC6551Implementation.sol";
import {ERC6551Registry} from "../src/blockMonster/ERC6551Registry.sol";
import {BlockMonster} from "../src/blockMonster/BlockMonster.sol";

contract EvolutionStoneTest is Test {
    EvolutionStone public mainContract;

    address owner = address(0x34A1D3fff3958843C43aD80F30b94c510645C316);
    address alice = address(0x1889);
    address bob = address(0x1778);

    function setUp() public {
        vm.startPrank(owner);
        mainContract = new EvolutionStone();

        mainContract.mint(1);

        vm.stopPrank();
    }

    function test_debug() public {
        string memory hoge = mainContract.buildMetadata(1);
        console2.log(hoge);
        // uint256 randomNum = stringMonsterContract.randonNum(361, block.prevrandao, 100);
        // console2.log(randomNum);
        // console2.log(stringMonsterContract.tokenURI(1));
        // assertEq(stringMonsterContract.name(), "StringMonster");
        assertEq(true, true);
    }
}
