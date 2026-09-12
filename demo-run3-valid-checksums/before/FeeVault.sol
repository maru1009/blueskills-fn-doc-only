// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IPriceFeed {
    function latestAnswer() external view returns (int256);
}

contract FeeVault {
    address public immutable router;
    address public immutable permit2;
    address public immutable treasury;

    address public priceFeed;
    address public keeper;
    address public owner;

    constructor(address _router, address _permit2, address _treasury, address _priceFeed, address _keeper) {
        router = _router;
        permit2 = _permit2;
        treasury = _treasury;
        priceFeed = _priceFeed;
        keeper = _keeper;
        owner = msg.sender;
    }

    /// Emergency path: used once already when the feed was migrated in March.
    function setPriceFeed(address feed) external {
        require(msg.sender == owner, "not owner");
        priceFeed = feed;
    }

    /// Values the accrued fees and sweeps them to the treasury.
    function sweep() external {
        require(msg.sender == keeper, "not keeper");
        int256 price = IPriceFeed(priceFeed).latestAnswer();
        require(price > 0, "bad price");
        payable(treasury).transfer(address(this).balance);
    }
}
