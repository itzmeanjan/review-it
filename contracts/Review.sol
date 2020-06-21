// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

contract Review {
    // deployer address
    address payable public author;

    constructor() public {
        author = msg.sender;
    }
}
