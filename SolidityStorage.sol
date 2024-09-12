//SPDX-License-Identifier:MIT

pragma solidity 0.8.18;

contract SimpleStorage{
    // Basic types: boolean, Uint,int,address,bytes
    uint256 favoriteNumber;
    function store( uint256 _favoriteNumber) public{
        favoriteNumber= _favoriteNumber;
    }

}