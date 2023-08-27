// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @dev Interface of EvolutionStone.
interface IEvolutionStone {
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
}
