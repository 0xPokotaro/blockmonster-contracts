// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721A} from "ERC721A/ERC721A.sol";

contract MockNFT is ERC721A {
    string private _baseTokenURI;

    bool private isStable = true;

    constructor() ERC721A("MockNFT", "MNFT") {
        _baseTokenURI = "ipfs://QmdtpBHMBT2amqcfL4qUgHXFYSwMpzocULHf3436GSq2Xb/MockNFT.png";
    }

    function mint(address to, uint256 tokenId) public {
        _mint(to, tokenId);
    }

    function setBaseTokenURI(string memory newBaseTokenURI) public {
        _baseTokenURI = newBaseTokenURI;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        if (isStable) {
            return _baseTokenURI;
        } else {
            return string(abi.encodePacked(_baseTokenURI, _toString(tokenId)));
        }
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }
}
