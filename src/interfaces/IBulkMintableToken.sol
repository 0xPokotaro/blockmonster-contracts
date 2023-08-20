// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IBulkMintableToken {
    function mint(address to, uint256 quantity) external;
    function owner() external view returns (address);
}
