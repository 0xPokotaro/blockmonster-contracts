// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {BmMintManager} from "../../../src/bmMintManager/BmMintManager.sol";

contract BmMintManagerScript is Script {
    BmMintManager mainContract;

    function setUp() public {}

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        mainContract = new BmMintManager();

        vm.stopBroadcast();
    }
}
