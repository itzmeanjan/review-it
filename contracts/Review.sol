// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

contract Review {
    // deployer address
    address payable public author;

    constructor() public {
        author = msg.sender;
    }

    // holds some useful pieces of information related to an item which can be
    // reviewed by registered reviewers present in dApp ecosystem
    struct Thing {
        bytes32 id;
        string name;
        string description;
        uint8 rate;
        uint256 rateCount;
        mapping(address => uint8) rates;
        uint256 reviewCount;
        mapping(address => string) reviews;
    }
}
