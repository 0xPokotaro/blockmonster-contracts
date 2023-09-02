// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IBmMintManager {
    error Unauthorized();
    error NotBulkMintableToken();
    error NotEnoughEther();
    error InsufficientFunds();

    function setMintableToken(
        address tokenAddress,
        uint256 price,
        address treasury
    ) external;
    function mint(address tokenAddress, uint256 quantity) external;
    function buy(address tokenAddress, uint256 quantity) external payable;
}
