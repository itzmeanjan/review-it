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

    // access control to certain ops
    modifier onlyAuthor() {
        require(msg.sender == author, "You're not author !");
        _;
    }

    // checks whether a given address is registered in dApp or not
    function isAddressRegistered(address _addr)
        public
        view
        onlyAuthor
        returns (bool)
    {
        return users[_addr].created;
    }

    // checks whether function invoker i.e. msg.sender is registered or not
    function amIRegistered() public view returns (bool) {
        return users[msg.sender].created;
    }

    modifier addressRegistered(address _addr) {
        require(users[_addr].created, "Address not registered yet !");
        _;
    }

    // given that a certain account ( _addr ) already registered,
    // it'll lookup user name by address
    //
    // person looking up information, also must be registered in dApp
    function userNameByAddress(address _addr)
        public
        view
        addressRegistered(msg.sender)
        addressRegistered(_addr)
        returns (string memory)
    {
        return users[_addr].name;
    }

    // looks up user name of msg.sender
    function myUserName() public view returns (string memory) {
        return userNameByAddress(msg.sender);
    }

    // given address of account holder, #-of things to
    // be reviewed created by user gets returned
    function thingCountByAddress(address _addr)
        public
        view
        addressRegistered(_addr)
        addressRegistered(msg.sender)
        returns (uint256)
    {
        return users[_addr].thingCount;
    }

    // returns #-of items to be reviewed, created by msg.sender
    function myThingCount() public view returns (uint256) {
        return thingCountByAddress(msg.sender);
    }

    // given address of account holder & index of thing we want to look up,
    // we'll return unique identifier for that thing
    function thingByAddressAndIndex(address _addr, uint256 _index)
        public
        view
        addressRegistered(_addr)
        addressRegistered(msg.sender)
        returns (bytes32)
    {
        require(
            _index >= 0 && _index < users[_addr].thingCount,
            "Invalid id of thing !"
        );

        return users[_addr].things[_index];
    }

    // returns thing identifier, given index of that thing, from msg.sender's account
    function myThingByIndex(uint256 _index) public view returns (bytes32) {
        return thingByAddressAndIndex(msg.sender, _index);
    }

    // given address of account holder, returns #-of things
    // rated by user
    function rateCountByAddress(address _addr)
        public
        view
        addressRegistered(_addr)
        addressRegistered(msg.sender)
        returns (uint256)
    {
        return users[_addr].rateCount;
    }

    // returns #-of items rated by user, where user == msg.sender
    function myRateCount() public view returns (uint256) {
        return rateCountByAddress(msg.sender);
    }

    // given address of account holder & index of rated thing,
    // we'll look up unique identifier associated with rated item
    // for given user with address `_addr`
    function ratedThingByAddressAndIndex(address _addr, uint256 _index)
        public
        view
        addressRegistered(_addr)
        addressRegistered(msg.sender)
        returns (bytes32)
    {
        require(
            _index >= 0 && _index < users[_addr].rateCount,
            "Invalid id of rated thing !"
        );

        return users[_addr].rates[_index];
    }

    // returns rated thing identifier, given index of that thing,
    // from msg.sender's account
    function myRatedThingByIndex(uint256 _index) public view returns (bytes32) {
        return ratedThingByAddressAndIndex(msg.sender, _index);
    }

    // given address of account holder, returns #-of things
    // reviewed by user
    function reviewCountByAddress(address _addr)
        public
        view
        addressRegistered(_addr)
        addressRegistered(msg.sender)
        returns (uint256)
    {
        return users[_addr].reviewCount;
    }

    // returns #-of items reviewed by user, where user == msg.sender
    function myReviewCount() public view returns (uint256) {
        return reviewCountByAddress(msg.sender);
    }

    // given address of account holder & index of rated thing,
    // we'll look up unique identifier associated with reviewed item
    // for given user with address `_addr`
    function reviewedThingByAddressAndIndex(address _addr, uint256 _index)
        public
        view
        addressRegistered(_addr)
        addressRegistered(msg.sender)
        returns (bytes32)
    {
        require(
            _index >= 0 && _index < users[_addr].reviewCount,
            "Invalid id of reviewed thing !"
        );

        return users[_addr].reviews[_index];
    }

    // returns reviewed thing identifier, given index of that thing,
    // from msg.sender's account
    function myReviewedThingByIndex(uint256 _index)
        public
        view
        returns (bytes32)
    {
        return reviewedThingByAddressAndIndex(msg.sender, _index);
    }
}
