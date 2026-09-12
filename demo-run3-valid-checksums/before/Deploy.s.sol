// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {FeeVault} from "../src/FeeVault.sol";

contract Deploy is Script {
    address constant ROUTER = 0xcF77a3Ba9A5CA399B7c97c74d54e5b1Beb874E43;
    address constant PERMIT2 = 0x000000000022D473030F116dDEE9F6B43aC78BA3;
    address constant TREASURY = 0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2;

    // Chainlink ETH/USD aggregator proxy on this chain
    address constant PRICE_FEED = 0x71041dddad3595F9CEd3DcCFBe3D1F4b0a16Bb70;
    // Our Gelato-triggered executor
    address constant KEEPER = 0x2A5c4b1F9EeB7d0384aB6C19f0d5E81ce7b3a946;

    function run() external {
        vm.startBroadcast();
        new FeeVault(ROUTER, PERMIT2, TREASURY, PRICE_FEED, KEEPER);
        vm.stopBroadcast();
    }
}
