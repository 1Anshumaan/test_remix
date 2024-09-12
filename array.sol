//SPDX-License-Identifier:Unlicensed

pragma solidity >=0.7.0;

contract array{
    uint [] public numbers =[1,2,3,4,45];
    function getArr() public view returns(uint[] memory){
        return numbers;
    }
}
