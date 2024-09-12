//SPDX-License-Identifier:MIT
pragma solidity ^0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
    function getPrice() internal view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        (int256 answer) = priceFeed.latestRoundData();
        return uint256(answer * 1e10);
    }
    function getconversionRate(uint256 ethAmount) internal view returns(uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethAmount*ethPrice);
        return ethAmountInUsd;
    } 
error NotOwner();

contract FundMe{
    using PriceConverter for uint256;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded; // Correct mapping syntax

    address[] public i_owner; // Assuming this is for storing owners or similar
    uint256 public constant MINIMUM_USD = 5 * 10 ** 18;
    }
    constructor() {
    i_owner = msg.sender;
    }
    function fund() public payable{
        require(msg.value.getconversionRate()>= MINIMUM_USD," You need more ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender]+msg.value;
    }
    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();

    }
    modifier onlyOwner(){
        //require(msg.sender==i_owner,"sender is not owner!");
        if(msg.sender != i_owner) revert NotOwner();
        _;
    }
    function withdraw() public{
        for(uint256 funderIndex = 0; funderIndex<funders.length;funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder]=0;
        }
        funders = new address[](0);
        (bool callSuccess,) = payable(msg.sender).calls{
            value:address(this).balance}("");
            require(callsSuccess, " Call failed");
        }
        
        receive() external payable {
            fund();
        }
        fallback() external payable {
            fund();
        }
    }   
    

    
