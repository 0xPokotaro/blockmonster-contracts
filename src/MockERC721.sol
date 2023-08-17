// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract MockNFT {
    uint256 public number;

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
