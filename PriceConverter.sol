//SPDX-License-Identifier:MIT
pragma solidity ^0.8.24;
import {AggregatorV3Interface} from "@cahinlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
    function getPrice() internal view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x68a2a5ca06bde9A009Dbf5A862C23b12514A32E7)
        ( ,int256 answer, , , ) = priceFeed.latestRoundData();
        return uint256(answer*1e10);
    }
    function getconversionRate(uint256 ethAmount) internal view returns(uint256){
        uint256 ethPrice = get Price();
        uint256 ethAmountInUsd=(ethPrice*ethAmount)
        return ethAmountInUsd
    }
}






function getPrice() public view returns(uint256){
        //Address
        //ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x70997970c51812dc3a010c7d01b50e0d17dc79c8)
        (,int256 price,,,)= priceFeed.latestRoundData();
        return uint256(price*1e10);

    }
    function getconversionRate(uint256 ethAmount)