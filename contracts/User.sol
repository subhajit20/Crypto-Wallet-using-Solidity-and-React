//SPDX-License-Identifier: UNLICENSED

// Solidity files have to start with this pragma.
// It will be used by the Solidity compiler to validate its version.
pragma solidity ^0.8.9;

contract User{
    struct UserDeatails{
        string name;
        address useraddress;
        uint saving_amount;
    }
    mapping(address=>UserDeatails) public Customer;
    address[] public userarray;

}