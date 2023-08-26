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
    function name(string memory _name, string memory tokenId) external pure returns (string memory) {
        return string(
            abi.encodePacked(
                '"name":"',
                _name,
                tokenId,
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

    function startTag() external pure returns (string memory) {
        return '{';
    }

    function endTag() external pure returns (string memory) {
        return '}';
    }

    function startSvg() external pure returns (string memory) {
        return '<svg width="1000" height="1000" viewBox="0 0 1000 1000" xmlns="http://www.w3.org/2000/svg">';
    }

    function endSvg() external pure returns (string memory) {
        return '</svg>';
    }

    function rect(string memory _color) external pure returns (string memory) {
        return string(
            abi.encodePacked(
                '<rect width="1000" height="1000" fill="',
                _color,
                '"/>'
            )
        );
    }
}

/// @title StringMonster
/// @author 0xpokotaro
/// @notice NFTs of monsters managed by ERC6551.
contract StringMonster is AccessControl, Ownable, ERC721A, IBlockMonster {
    using Strings for uint256;

    /// NFT VARIABLES
    bytes32 public constant MINTER_ROLE = keccak256('MINTER_ROLE');
    uint256 public constant MAX_SUPPLY = 10000;
    uint256 public constant MAX_MINTABLE = 10;

    struct MonsterType {
        string monsterType;
        string color;
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
    uint salt = 0;

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
        string memory monsterType,
        string memory color
    ) external onlyOwner {
        monsterTypes[monsterTypeId] = MonsterType(monsterType, color);
    }

    /// ===========================================
    /// Build functions
    /// ===========================================

    function buildImage(uint256 _tokenId) public view returns (string memory) {
        address account = getAccount(_tokenId);
        uint256 balance = evolutionStone.balanceOf(account);

        string memory color;
        string memory monsterType;

        if (balance == 0) {
            /// 進化していない場合
            color = monsterTypes[tokenIdsMonsterType[_tokenId]].color;
            monsterType = monsterTypes[tokenIdsMonsterType[_tokenId]].monsterType;
        } else {
            // 進化している場合
            color = monsterTypes[9].color;
            monsterType = monsterTypes[9].monsterType;
        }

        return Base64.encode(
            abi.encodePacked(
                Uri.startSvg(),
                Uri.rect(color),
                '<text x="80" y="200" fill="white" font-family="Helvetica" font-size="120" font-weight="bold">StringMonster</text>',
                '<text x="80" y="350" fill="white" font-family="Helvetica" font-size="60" font-weight="bold">ID: ',
                _tokenId.toString(),
                '</text>',
                '<text x="80" y="450" fill="white" font-family="Helvetica" font-size="60" font-weight="bold">TYPE: ',
                monsterType,
                '</text>',
                Uri.endSvg()
            )
        );
    }

    function buildMetadata(uint256 _tokenId) public view returns (string memory) {
        address account = getAccount(_tokenId);
        uint256 balance = evolutionStone.balanceOf(account);

        string memory color;
        string memory monsterType;

        if (balance == 0) {
            /// 進化していない場合
            color = monsterTypes[tokenIdsMonsterType[_tokenId]].color;
            monsterType = monsterTypes[tokenIdsMonsterType[_tokenId]].monsterType;
        } else {
            // 進化している場合
            color = monsterTypes[9].color;
            monsterType = monsterTypes[9].monsterType;
        }

        string[] memory uriParts = new string[](4);
        uriParts[0] = string("data:application/json;base64,");

        string[] memory attributes = new string[](1);
        attributes[0] = Uri.attribute("Type", monsterType);

        uriParts[1] = string(
            abi.encodePacked(
                Uri.startTag(),
                Uri.name("StringMonster #", _tokenId.toString()),
                Uri.description("NFTs of monsters managed by ERC6551."),
                Uri.attributes(attributes),
                '"image":"data:image/svg+xml;base64,'
            )
        );
        uriParts[2] = buildImage(_tokenId);
        uriParts[3] = string(abi.encodePacked(
            '"',
            Uri.endTag()
        ));

        string memory uri = string.concat(
            uriParts[0],
            Base64.encode(
                abi.encodePacked(uriParts[1], uriParts[2], uriParts[3])
            )
        );

        return uri;
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
