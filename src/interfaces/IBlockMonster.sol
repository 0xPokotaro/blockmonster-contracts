// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @dev Interface of BlockMonster.
interface IBlockMonster {
    /// ===========================================
    /// Errors
    /// ===========================================

    error ExceedsMaxSupply();
    error InvalidMonsterType();
    error Unauthorized();

    /// ===========================================
    /// Functions
    /// ===========================================

    // function mint(address to, uint256 quantity) external;
    function getAccount(uint tokenId) external view returns (address);
    function createAccount(uint tokenId) external returns (address);
}
