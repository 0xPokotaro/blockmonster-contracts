// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IBulkMintableToken} from "./interfaces/IBulkMintableToken.sol";
import {IMintableToken} from "./interfaces/IMintableToken.sol";
import {IERC721MintManager} from "./interfaces/IERC721MintManager.sol";

contract ERC721MintManager is IERC721MintManager {
    /// MintManager VARIABLES
    uint8 public constant IS_ACTIVE = 1;

    struct BulkMintableToken {
        uint256 price;
        address treasury;
        uint8 isActive;
    }

    struct MintableToken {
        uint256 price;
        address treasury;
        uint8 isActive;
    }

    mapping (address => BulkMintableToken) public bulkMintableTokens;
    mapping (address => MintableToken) public mintableTokens;

    /// ===========================================
    /// Constructor
    /// ===========================================

    constructor() {}

    /// ===========================================
    /// Set functions
    /// ===========================================

    function setBulkMintableToken(
        address tokenAddress,
        uint256 price,
        address treasury
    ) external {
        IBulkMintableToken token = IBulkMintableToken(tokenAddress);
        if (token.owner() != msg.sender) revert Unauthorized();

        bulkMintableTokens[tokenAddress].price = price;
        bulkMintableTokens[tokenAddress].treasury = treasury;
        bulkMintableTokens[tokenAddress].isActive = IS_ACTIVE;
    }

    function setMintableToken(
        address tokenAddress,
        uint256 price,
        address treasury
    ) external {
        IMintableToken token = IMintableToken(tokenAddress);
        if (token.owner() != msg.sender) revert Unauthorized();

        mintableTokens[tokenAddress].price = price;
        mintableTokens[tokenAddress].treasury = treasury;
        mintableTokens[tokenAddress].isActive = IS_ACTIVE;
    }

    /// ===========================================
    /// Mint functions
    /// ===========================================

    function bulkMint(
        address tokenAddress,
        uint256 quantity
    )
        external
        payable
    {
        if (bulkMintableTokens[tokenAddress].isActive != IS_ACTIVE) revert NotBulkMintableToken();
        if (msg.value < bulkMintableTokens[tokenAddress].price * quantity) revert InsufficientFunds();

        IBulkMintableToken bulkMintableToken = IBulkMintableToken(tokenAddress);
        bulkMintableToken.mint(msg.sender, quantity);

        payable(bulkMintableTokens[tokenAddress].treasury).transfer(msg.value);
    }

    function mint(
        address tokenAddress
    )
        external
        payable
    {
        if (mintableTokens[tokenAddress].isActive != IS_ACTIVE) revert NotMintableToken();
        if (msg.value < mintableTokens[tokenAddress].price) revert InsufficientFunds();

        IMintableToken mintableToken = IMintableToken(tokenAddress);
        mintableToken.mint(msg.sender);

        payable(mintableTokens[tokenAddress].treasury).transfer(msg.value);
    }
}
