// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC721MintManager {
    /// ===========================================
    /// Errors
    /// ===========================================

    error InsufficientFunds();
    error NotBulkMintableToken();
    error NotMintableToken();
    error Unauthorized();

    /// ===========================================
    /// Functions
    /// ===========================================

    function setBulkMintableToken(
        address tokenAddress,
        uint256 price,
        address treasury
    ) external;
    function setMintableToken(
        address tokenAddress,
        uint256 price,
        address treasury
    ) external;
    function bulkMint(address tokenAddress,uint256 quantity) external payable;
    function mint(address tokenAddress) external payable;
}
