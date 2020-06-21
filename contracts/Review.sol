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

    // holding some useful pieces of information related to one
    // registered user in dApp ecosystem
    //
    // All {things} created by this user, to be reviewed by dApp participants, stored in blockchain
    //
    // All reviews & rating done by user to be stored on blockchain
    struct User {
        string name;
        bool created;
        uint256 thingCount;
        mapping(uint256 => bytes32) things;
        uint256 rateCount;
        mapping(uint256 => bytes32) rates;
        uint256 reviewCount;
        mapping(uint256 => bytes32) reviews;
    }

    uint256 thingCount;
    mapping(bytes32 => Thing) things;
    uint256 userCount;
    mapping(address => User) users;
    mapping(bytes32 => address) thingsToUser;
}
