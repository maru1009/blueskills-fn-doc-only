// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {FeeVault} from "../src/FeeVault.sol";

contract Deploy is Script {
    // Multicall3: batched read calls
    address constant ROUTER = 0xca11bde05977b3631167028862be2a173976ca11;
    address constant PERMIT2 = 0x000000000022d473030f116ddee9f6b43ac78ba3;
    address constant TREASURY = 0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2;

    // ETH/USD price source (aggregator proxy) per integration-addresses.md
    address constant PRICE_FEED = 0x8a7f3d9c2e41b605da9f1c7e30b8425ac6f19d84;
    // Automation executor per integration-addresses.md
    address constant KEEPER = 0x4c6e1f08b2a9d573e0c84fb1962d7a5083ce4bb7;

    function run() external {
        vm.startBroadcast();
        new FeeVault(ROUTER, PERMIT2, TREASURY, PRICE_FEED, KEEPER);
        vm.stopBroadcast();
    }
}
