// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {console2} from "forge-std/console2.sol";
import {Script} from "forge-std/Script.sol";
import {BlockMonster} from "../../src/blockMonster/BlockMonster.sol";

contract MintScript is Script {
    BlockMonster mainContract;

    address implementation = 0xC1Af53a83Af5feB946F1C7ca4a90d2C16D0D9c8c;
    address registry = 0x42735056E2173C1f4eA24d8753169724FC1685Ab;
    address evolutionStone = 0xdAF5482B37746B6DF11D1B3a7e18536b9539d8c5;

    function setUp() public {
        // mainContract = BlockMonster("0x6650783bcac7aca61cdb72aa94a6e7a9001d6224");
    }

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // デプロイ済みのコントラクトでミントを行う
        mainContract.mint(1, 1);

        vm.stopBroadcast();
    }
}
