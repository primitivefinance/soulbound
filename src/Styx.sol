// SPDX-License-Identifier: GPL-3.0-only
pragma solidity >=0.8.0;

interface ISoulbound {
    function file(bytes32 what, uint256 data) external;

    function bump(address gene) external;
}

contract Styx {
    address public star;
    address public immutable ward;

    error Sour();
    error Deny();

    constructor() {
        ward = msg.sender;
    }

    function init(address what) public {
        if (msg.sender != ward) revert Deny();
        if (star != address(0x0)) revert Sour();
        star = what;
    }

    function leap(uint256 flow) public {
        if (msg.sender != ward) revert Deny();
        if (flow > 700 days || flow < 2 days) revert Sour();
        ISoulbound(star).file("flow", flow);
    }

    function sail(uint256 life) public {
        if (msg.sender != ward) revert Deny();
        if (life > 36_135 days || life < 701 days) revert Sour();
        ISoulbound(star).file("life", life);
    }

    function mine(address gene) public {
        if (msg.sender != ward) revert Deny();
        ISoulbound(star).bump(gene);
    }
}
