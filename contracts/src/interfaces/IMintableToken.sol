// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IMintableToken {
    function mint(address to) external;
    function owner() external view returns (address);
}
