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

/// @title BlockMonster
/// @author 0xpokotaro
/// @notice NFTs of monsters managed by ERC6551.
contract BlockMonster is AccessControl, Ownable, ERC721A, IBlockMonster {
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
    ) ERC721A("BlockMonster", "BM") {
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
    /// ERC721A functions
    /// ===========================================

    function mint(uint256 monsterTypeId, uint256 quantity) external {
        if (monsterTypeId > 4) revert InvalidMonsterType();

        _mint(msg.sender, quantity);

        for (uint256 i = 0; i < quantity; i++) {
            uint256 tokenId = totalSupply() + i + 1;
            tokenIdsMonsterType[tokenId] = monsterTypeId;

            createAccount(tokenId);
        }
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override(ERC721A)
        returns (string memory)
    {
        if (!_exists(tokenId)) revert ApprovalQueryForNonexistentToken();

        address account = getAccount(tokenId);
        uint256 balance = evolutionStone.balanceOf(account);

        string[] memory uriParts = new string[](4);
        uriParts[0] = string("data:application/json;base64,");

        string memory color;
        string memory monsterType;

        if (balance == 0) {
            /// 進化していない場合
            color = monsterTypes[tokenIdsMonsterType[tokenId]].color;
            monsterType = monsterTypes[tokenIdsMonsterType[tokenId]].monsterType;
        } else {
            // 進化している場合
            color = monsterTypes[9].color;
            monsterType = monsterTypes[9].monsterType;
        }

        uriParts[1] = string(
            abi.encodePacked(
                '{"name":"BlockMonster #',
                tokenId.toString(),
                '",',
                '"description":" NFTs of monsters managed by ERC6551.",',
                '"attributes":[{"trait_type":"Type","value":"',
                monsterType,
                '"}],',
                '"image":"data:image/svg+xml;base64,'
            )
        );
        uriParts[2] = Base64.encode(
            abi.encodePacked(
                '<svg width="1000" height="1000" viewBox="0 0 1000 1000" xmlns="http://www.w3.org/2000/svg">',
                '<rect width="1000" height="1000" fill="',
                color,
                '"/>',
                '<text x="80" y="200" fill="white" font-family="Helvetica" font-size="120" font-weight="bold">BlockMonster</text>',
                '<text x="80" y="350" fill="white" font-family="Helvetica" font-size="60" font-weight="bold">ID: ',
                tokenId.toString(),
                '</text>',
                '<text x="80" y="450" fill="white" font-family="Helvetica" font-size="60" font-weight="bold">TYPE: ',
                monsterType,
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
}
