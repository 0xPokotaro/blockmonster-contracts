// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IBmMintManager} from "../interfaces/IBmMintManager.sol";

interface MintableNft {
    function owner() external returns (address);
    function mint(address to, uint256 quantity) external;
}

contract BmMintManager is IBmMintManager {
    /// MintManager VARIABLES
    uint8 public constant IS_ACTIVE = 1;

    struct MintableToken {
        uint256 price;
        address treasury;
        uint8 isActive;
    }

    mapping (address => MintableToken) public mintableTokens;

    /// ===========================================
    /// Constructor
    /// ===========================================

    constructor() {}

    /// ===========================================
    /// Set functions
    /// ===========================================

    function setMintableToken(
        address _tokenAddress,
        uint256 _price,
        address _treasury
    ) external {
        MintableNft token = MintableNft(_tokenAddress);
        if (token.owner() != msg.sender) revert Unauthorized();

        MintableToken memory mintableToken = MintableToken(
            _price,
            _treasury,
            IS_ACTIVE
        );

        mintableTokens[_tokenAddress] = mintableToken;
    }

    /// ===========================================
    /// Mint functions
    /// ===========================================

    function mint(
        address tokenAddress,
        uint256 quantity
    )
        external
    {
        // if (mintableTokens[tokenAddress].isActive != IS_ACTIVE) revert NotBulkMintableToken();

        MintableNft token = MintableNft(tokenAddress);
        token.mint(msg.sender, quantity);
    }

    function buy(
        address tokenAddress,
        uint256 quantity
    )
        external
        payable
    {
        // if (mintableTokens[tokenAddress].isActive != IS_ACTIVE) revert NotBulkMintableToken();
        if (msg.value < mintableTokens[tokenAddress].price * quantity) revert InsufficientFunds();

        MintableNft token = MintableNft(tokenAddress);
        token.mint(msg.sender, quantity);

        payable(mintableTokens[tokenAddress].treasury).transfer(msg.value);
    }
}
