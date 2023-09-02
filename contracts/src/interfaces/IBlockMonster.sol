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

    function setMonsterType(
        uint256 monsterTypeId,
        string memory bType,
        string memory bColor,
        string memory aType,
        string memory aColor
    ) external;
    function getIsEvolution(uint256 _tokenId) external view returns (bool);
    function getMonsterType(uint256 _tokenId) external view returns (string memory);
    function getMonsterColor(uint256 _tokenId) external view returns (string memory);
    function buildImage(uint256 _tokenId) external view returns (string memory);
    function buildMetadata(uint256 _tokenId) external view returns (string memory);
    function mint(address _to, uint256 _quantity) external;
    function getAccount(uint tokenId) external view returns (address);
    function createAccount(uint tokenId) external returns (address);
}
