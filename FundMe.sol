//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// get withdraws 
//Withdraw fund
//Set minimum funding value in USD

import "./PriceConverter.sol";

contract FundMe {

    using PriceConverter for uint256;

    uint256 public min_usd = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;


    function fund() public payable {
        //want to be able to set a mininium fund amount in USD
        //1. How do we send ETH to this contract
        
        require(msg.value.getConversionRate() >= min_usd, "Did'nt send enough eth");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }


    function withdraw() public {
        for(uint256 funderIndex =0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        //reset array
        funders = new address[](0);
        
        //withdraw funds

        //transfer
        // payable(msg.sender).transfer(address(this).balance);
        
        //send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "send Failed");
        
        //call
       (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
       require(callSuccess, "Called failed");

    }
}