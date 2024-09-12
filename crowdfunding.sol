//SPDX-License-Identifier:UNLICENSED
pragma solidity >= 0.5.0 <0.9.0;

contract crowdfunding{
    mapping(address=>uint) public contributors;
    address public manager;
    uint public minimumcontribution;
    uint public deadline;
    uint public target;
    uint public raisedAmount;
    uint public noofcontributors;

    struct Request{
        string description;
        address payable recipient;
        uint value;
        bool completed;
        uint noofvoters;
        mapping(address=>bool) voters;
    }

    mapping(uint=>Request) public request;
    uint public numRequest;
    constructor(uint _target,uint _deadline){
        target = _target;
        deadline = block.timestamp+_deadline;
        minimumcontribution = 100 wei;
        manager=msg.sender;
    }

    function sendEth() public payable{
        require(block.timestamp<deadline,"Deadline has passed");
        require(msg.value>=minimumcontribution,"Minimum contribution is not met");
        if(contributors[msg.sender]==0){
            noofcontributors++;
        }
        contributors[msg.sender]+=msg.value;
        raisedAmount+=msg.value;
    }
    function getcontractBalance() public view returns(uint){
        return address(this).balance;
    }

    function refund() public{
        require(block.timestamp>deadline && raisedAmount<target,"You are not eligible for refund");
        require(contributors[msg.sender]>0);
        address payable user= payable(msg.sender);
        user.transfer(contributors[msg.sender]);
        contributors[msg.sender]=0;
    }

    modifier onlyManager(){
        require(msg.sender==manager,"only manager can call this function");
        _;
    }

    function createRequest(string memory _description,address payable _recipient,uint _value) public onlyManager{
        Request storage newRequest=requests[numrequests ];
        numRequest++;
        newRequest.description=_description;
        newRequest.recipient=_recipient;
        newRequest.value=_value;
        newRequest.completed=false;
        newRequest.noofvoter=0;
    }

    function voteRequest(uint _requestNo) public{
        require (contributors[msg.sender]>0,"You must be contributor");
        Request storage thisRequest=requests[_requestNo];
        require(thisRequest.voters[msg.Sender]==false,"You have already voted");
        thisRequest.voters[msg.Sender]=true;
        thisRequest.noofvoter++;
    }

    function makepayment(uint _requestNo) public onlyManager{
        require(raisedAmount>=target);
        Request storage thisRequest=requests[_requestNo];
        require(thisRequest.Completed==false,"The request has been completed");
        require(thisRequest.noofvoters>noofcontributors/2,"Majority does not support");
        thisRequest.recipient.transfer(thisRequest.value);
        thisRequest.completed=true;
    }

}