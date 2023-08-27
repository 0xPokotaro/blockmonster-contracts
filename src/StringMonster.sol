// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// util imports
import {Base64} from "base64-sol/base64.sol";
import {Strings} from "openzeppelin-contracts/utils/Strings.sol";
/// contract imports
import {AccessControl} from "openzeppelin-contracts/access/AccessControl.sol";
import {Ownable} from "openzeppelin-contracts/access/Ownable.sol";
import {ERC721A} from "ERC721A/ERC721A.sol";
/// interface imports
import {IERC6551Registry} from "reference/interfaces/IERC6551Registry.sol";
import {IERC721A} from "ERC721A/interfaces/IERC721A.sol";
import {IBlockMonster} from "./interfaces/IBlockMonster.sol";

library Uri {
    function jsonBase64Header() external pure returns (string memory) {
        return "data:application/json;base64,";
    }

    function name(string memory _name, string memory _tokenId) external pure returns (string memory) {
        return string(
            abi.encodePacked(
                '"name":"',
                _name,
                " #",
                _tokenId,
                '",'
            )
        );
    }

    function description(string memory _description) external pure returns (string memory) {
        return string(
            abi.encodePacked(
                '"description":"',
                _description,
                '",'
            )
        );
    }

    function attribute(string memory _traitType, string memory _value) external pure returns(string memory) {
        return string(
            abi.encodePacked(
                '{"trait_type":"',
                _traitType,
                '","value":"',
                _value,
                '"}'
            )
        );
    }

    function attributes(string[] memory _attributes) external pure returns (string memory) {
        string memory atts = string(abi.encodePacked('"attributes":['));

        for (uint256 i = 0; i < _attributes.length; i++) {
            atts = string(abi.encodePacked(atts, _attributes[i]));
            if (i != _attributes.length - 1) {
                atts = string(abi.encodePacked(atts, ','));
            }
        }

        atts = string(abi.encodePacked(atts, '],'));

        return atts;
    }

    function image(string memory _image) external pure returns (string memory) {
        return string(
            abi.encodePacked(
                '"image":"data:image/svg+xml;base64,',
                _image,
                '"'
            )
        );
    }

    function startTag() external pure returns (string memory) {
        return '{';
    }

    function endTag() external pure returns (string memory) {
        return '}';
    }

    function startSvg() external pure returns (string memory) {
        return '<svg width="500" height="500" viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg">';
    }

    function endSvg() external pure returns (string memory) {
        return '</svg>';
    }

    function rect() external pure returns (string memory) {
        return string(
            abi.encodePacked(
                '<rect width="500" height="500" fill="white"/>'
            )
        );
    }

    function monster(string memory _monsterType, string memory _color) external pure returns (string memory) {
        return string(
            abi.encodePacked(
                // title
                '<text x="10" y="30" font-family="Verdana" font-size="24" font-weight="bold" fill="black">Monster</text>',
                // attribute
                '<text x="10" y="60" font-family="Verdana" font-size="16" fill="black">Attribute: ',
                _monsterType,
                '</text>',
                // body
                '<ellipse cx="250" cy="250" rx="150" ry="120" style="fill:',
                _color,
                ';" />',
                // eyes
                '<circle cx="210" cy="220" r="15" style="fill:white;" />',
                '<circle cx="290" cy="220" r="15" style="fill:white;" />',
                '<circle cx="210" cy="220" r="7.5" style="fill:black;" />',
                '<circle cx="290" cy="220" r="7.5" style="fill:black;" />',
                // mouth
                '<rect x="235" y="280" rx="7.5" ry="7.5" width="22.5" height="7.5" style="fill:black;" />'
            )
        );
    }
}

/// @title StringMonster
/// @author 0xpokotaro
/// @notice NFTs of monsters managed by ERC6551.
contract StringMonster is AccessControl, Ownable, ERC721A, IBlockMonster {
    using Strings for uint256;

    string public constant NAME = "StringMonster";

    /// NFT VARIABLES
    bytes32 public constant MINTER_ROLE = keccak256('MINTER_ROLE');
    uint256 public constant MAX_SUPPLY = 10000;
    uint256 public constant MAX_MINTABLE = 10;

    // b: before evolution, a: after evolution
    struct MonsterType {
        string bType;
        string bColor;
        string aType;
        string aColor;
    }

    mapping (uint256 => MonsterType) public monsterTypes;
    mapping (uint256 => uint256) public tokenIdsMonsterType;

    /// EvolutionStone VARIABLES
    IERC721A public immutable evolutionStone;

    /// ERC6551 VARIABLES
    address public immutable implementation;
    IERC6551Registry public immutable registry;
    uint public immutable chainId = block.chainid;
    address public immutable tokenContract = address(this);
    uint public salt = 0;

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

    constructor(
        address _implementation,
        address _registry,
        address _evolutionStone
    ) ERC721A("StringMonster", "SM") {
        implementation = _implementation;
        registry = IERC6551Registry(_registry);
        evolutionStone = IERC721A(_evolutionStone);

        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    /// ===========================================
    /// BlockMonster functions
    /// ===========================================

    function setMonsterType(
        uint256 monsterTypeId,
        string memory bType,
        string memory bColor,
        string memory aType,
        string memory aColor
    ) external onlyOwner {
        monsterTypes[monsterTypeId] = MonsterType(bType, bColor, aType, aColor);
    }

    function getIsEvolution(uint256 _tokenId) public view returns (bool) {
        address account = getAccount(_tokenId);
        uint256 balance = evolutionStone.balanceOf(account);

        return balance > 0;
    }

    function getMonsterType(uint256 _tokenId) public view returns (string memory) {
        bool isEvolution = getIsEvolution(_tokenId);

        if (isEvolution) {
            return monsterTypes[tokenIdsMonsterType[_tokenId]].bType;
        } else {
            return monsterTypes[tokenIdsMonsterType[_tokenId]].aType;
        }
    }

    function getMonsterColor(uint256 _tokenId) public view returns (string memory) {
        bool isEvolution = getIsEvolution(_tokenId);

        if (isEvolution) {
            return monsterTypes[tokenIdsMonsterType[_tokenId]].bColor;
        } else {
            return monsterTypes[tokenIdsMonsterType[_tokenId]].aColor;
        }
    }

    /// ===========================================
    /// Build functions
    /// ===========================================

    function buildImage(uint256 _tokenId) public view returns (string memory) {
        string memory monsterType = getMonsterType(_tokenId);
        string memory color = getMonsterColor(_tokenId);

        return Base64.encode(
            abi.encodePacked(
                Uri.startSvg(),
                Uri.rect(),
                Uri.monster(monsterType, color),
                Uri.endSvg()
            )
        );
    }

    function buildMetadata(uint256 _tokenId) public view returns (string memory) {
        string memory monsterType = getMonsterType(_tokenId);

        string[] memory attributes = new string[](1);
        attributes[0] = Uri.attribute("Type", monsterType);

        string memory image = buildImage(_tokenId);

        return string(abi.encodePacked(
            Uri.jsonBase64Header(),
            Base64.encode(
                bytes(abi.encodePacked(
                    Uri.startTag(),
                    Uri.name(NAME, _tokenId.toString()),
                    Uri.description("NFTs of monsters managed by ERC6551."),
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

    function mint(uint256 monsterTypeId, uint256 quantity) external {
        if (monsterTypeId > 4) revert InvalidMonsterType();

        for (uint256 i = 0; i < quantity; i++) {
            uint256 tokenId = totalSupply() + 1;
            tokenIdsMonsterType[tokenId] = monsterTypeId;

            createAccount(tokenId);
        }

        _mint(msg.sender, quantity);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        if (!_exists(tokenId)) revert ApprovalQueryForNonexistentToken();
        return buildMetadata(tokenId);
    }

    function _startTokenId() internal pure override returns (uint256) {
        return 1;
    }

    /// ===========================================
    /// ERC6551 Register functions
    /// ===========================================

    function getAccount(uint tokenId) public view returns (address) {
        return
            registry.account(
                implementation,
                chainId,
                tokenContract,
                tokenId,
                salt
            );
    }

    function createAccount(uint tokenId) public returns (address) {
        return
            registry.createAccount(
                implementation,
                chainId,
                tokenContract,
                tokenId,
                salt,
                ""
            );
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

    /// ===========================================
    /// Internal functions
    /// ===========================================
}
