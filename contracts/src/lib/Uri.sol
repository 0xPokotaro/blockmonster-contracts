// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

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

    function stone(string memory _title, string memory _tokenId) external pure returns (string memory) {
       return string(
            abi.encodePacked(
                // title
                '<text x="25" y="80" font-family="Verdana" font-size="45" font-weight="bold" fill="black">',
                _title,
                '</text>',
                // attribute
                '<text x="25" y="120" font-family="Verdana" font-size="16" fill="black"># ',
                _tokenId,
                '</text>',
                '<polygon points="250,200 300,300 200,300" fill="blue"/>',
                '<polygon points="300,300 250,400 200,300" fill="darkblue"/>',
                '<polygon points="250,200 300,300 250,400 200,300" stroke="black" stroke-width="3" fill="none"/>'
            )
        );
    }
}
