// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// CONTRACTS
import {AccessControl} from "openzeppelin-contracts/access/AccessControl.sol";
import {Ownable} from "openzeppelin-contracts/access/Ownable.sol";
import {ERC721A} from "ERC721A/ERC721A.sol";
/// UTILS
import {Base64} from "base64-sol/base64.sol";
import {Strings} from "openzeppelin-contracts/utils/Strings.sol";
import {Uri} from "./lib/Uri.sol";

/*

███████╗██╗   ██╗ ██████╗ ██╗     ██╗   ██╗████████╗██╗ ██████╗ ███╗   ██╗
██╔════╝██║   ██║██╔═══██╗██║     ██║   ██║╚══██╔══╝██║██╔═══██╗████╗  ██║
█████╗  ██║   ██║██║   ██║██║     ██║   ██║   ██║   ██║██║   ██║██╔██╗ ██║
██╔══╝  ╚██╗ ██╔╝██║   ██║██║     ██║   ██║   ██║   ██║██║   ██║██║╚██╗██║
███████╗ ╚████╔╝ ╚██████╔╝███████╗╚██████╔╝   ██║   ██║╚██████╔╝██║ ╚████║
╚══════╝  ╚═══╝   ╚═════╝ ╚══════╝ ╚═════╝    ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
███████╗████████╗ ██████╗ ███╗   ██╗███████╗
██╔════╝╚══██╔══╝██╔═══██╗████╗  ██║██╔════╝
███████╗   ██║   ██║   ██║██╔██╗ ██║█████╗
╚════██║   ██║   ██║   ██║██║╚██╗██║██╔══╝
███████║   ██║   ╚██████╔╝██║ ╚████║███████╗
╚══════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═══╝╚══════╝

*/

// ERRORS
error Unauthorized();
error ExceedsMaxSupply();

/// @title EvolutionStone
/// @author https://x.com/0xpokotaro
contract EvolutionStone is AccessControl, Ownable, ERC721A {
    using Strings for uint256;

    string public constant NAME = "EvolutionStone";

    /// NFT VARIABLES
    bytes32 public constant MINTER_ROLE = keccak256('MINTER_ROLE');
    uint256 public constant MAX_SUPPLY = 10000;

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

    constructor() ERC721A(NAME, "ES") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    /// ===========================================
    /// Build functions
    /// ===========================================

    function buildImage(uint256 _tokenId) public pure returns (string memory) {
        return Base64.encode(
            abi.encodePacked(
                Uri.startSvg(),
                Uri.rect(),
                Uri.stone(NAME, _tokenId.toString()),
                Uri.endSvg()
            )
        );
    }

    function buildMetadata(uint256 _tokenId) public pure returns (string memory) {
        string[] memory attributes = new string[](1);
        attributes[0] = Uri.attribute("Type", NAME);

        string memory image = buildImage(_tokenId);

        return string(abi.encodePacked(
            Uri.jsonBase64Header(),
            Base64.encode(
                bytes(abi.encodePacked(
                    Uri.startTag(),
                    Uri.name(NAME, _tokenId.toString()),
                    Uri.description("It's a magical stone that can evolve BlockMonster."),
                    Uri.attributes(attributes),
                    Uri.image(image),
                    Uri.endTag()
                ))
            )
        ));
    }

    /// ===========================================
    /// ERC721A functions
    /// ===========================================

    function mint(uint256 quantity) external {
        if (totalSupply() + quantity > MAX_SUPPLY) revert ExceedsMaxSupply();

        _mint(msg.sender, quantity);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override(ERC721A)
        returns (string memory)
    {
        if (!_exists(tokenId)) revert ApprovalQueryForNonexistentToken();
        return buildMetadata(tokenId);
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
