// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MockNFT} from "../src/MockNFT.sol";

contract MockNFTScript is Script {
    MockNFT mockNftContract;

    function setUp() public {}

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        mockNftContract = new MockNFT();

        vm.stopBroadcast();
    }
}
