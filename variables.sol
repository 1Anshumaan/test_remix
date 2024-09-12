// SPDX-License-Identifier: MIT
pragma solidity ^0.7.5;
contract variable{
    uint public val=3; // static variable store in blockchain
    function add() public pure returns(uint){
        uint val2 = 2;//local variable
        return 4;
    }

    function global() public view returns(address){
        return msg.sender;
    }
}