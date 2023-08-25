// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/StringMonster.sol";

contract StringMonsterTest is Test {
    StringMonster public stringMonster;

    function setUp() public {
        // stringMonster = new StringMonster(implementation, registry, evolutionStone);
    }
}

/*
contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
        counter.setNumber(0);
    }

    function testIncrement() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testSetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }
}
*/
