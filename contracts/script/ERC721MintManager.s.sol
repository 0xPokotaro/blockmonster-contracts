// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {ERC721MintManager} from "../src/ERC721MintManager.sol";

contract ERC721MintManagerScript is Script {
    ERC721MintManager mainContract;

    function setUp() public {}

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        mainContract = new ERC721MintManager();

        vm.stopBroadcast();
    }
}
