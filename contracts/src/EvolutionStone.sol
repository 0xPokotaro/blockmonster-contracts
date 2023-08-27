// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Base64} from "base64-sol/base64.sol";
import {Strings} from "openzeppelin-contracts/utils/Strings.sol";
import {AccessControl} from "openzeppelin-contracts/access/AccessControl.sol";
import {Ownable} from "openzeppelin-contracts/access/Ownable.sol";
import {ERC721A} from "ERC721A/ERC721A.sol";
import {IEvolutionStone} from "./interfaces/IEvolutionStone.sol";

/// @title EvolutionStone
/// @author 0xpokotaro
contract EvolutionStone is AccessControl, Ownable, ERC721A, IEvolutionStone {
    using Strings for uint256;

    /// NFT VARIABLES
    bytes32 public constant MINTER_ROLE = keccak256('MINTER_ROLE');
    uint256 public constant MAX_SUPPLY = 10000;
    uint256 public constant MAX_MINTABLE = 10;

    /// ===========================================
    /// Modifiers
    /// ===========================================

    modifier onlyMinter() {
        if (hasRole(MINTER_ROLE, msg.sender)) revert Unauthorized();
        _;
    }

    /// ===========================================
    /// Constructor
    /// ===========================================

    constructor() ERC721A("EvolutionStone", "ES") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    /// ===========================================
    /// ERC721A functions
    /// ===========================================

    function mint(uint256 quantity) external {
        _mint(msg.sender, quantity);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override(ERC721A)
        returns (string memory)
    {
        string[] memory uriParts = new string[](4);

        uriParts[0] = string("data:application/json;base64,");
        uriParts[1] = string(
                abi.encodePacked(
                    '{"name":"EvolutionStone #',
                    tokenId.toString(),
                    '",',
                    '"description":" Evolution stones in BlockMonster are in-game items used to evolve specific BlockMonster into a new form.",',
                    '"attributes":[{"trait_type":"Type","value":"Stone"}],',
                    '"image":"data:image/svg+xml;base64,'
                )
            );
        uriParts[2] = Base64.encode(
                abi.encodePacked(
                    '<svg width="1000" height="1000" viewBox="0 0 1000 1000" xmlns="http://www.w3.org/2000/svg">',
                    '<rect width="1000" height="1000" fill="black"/>',
                    '<text x="80" y="200" fill="white" font-family="Helvetica" font-size="120" font-weight="bold">BlockMonster</text>',
                    '<text x="80" y="350" fill="white" font-family="Helvetica" font-size="60" font-weight="bold">ID: ',
                    tokenId.toString(),
                    '</text>',
                    '</svg>'
                )
            );
        uriParts[3] = string('"}');

        string memory uri = string.concat(
            uriParts[0],
            Base64.encode(
                abi.encodePacked(uriParts[1], uriParts[2], uriParts[3])
            )
        );

        return uri;
    }

    function _startTokenId() internal pure override returns (uint256) {
        return 1;
    }

    /// ===========================================
    /// Supports interface
    /// ===========================================

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(AccessControl, ERC721A)
        returns (bool)
    {
        return
            AccessControl.supportsInterface(interfaceId) ||
            ERC721A.supportsInterface(interfaceId);
    }
}
