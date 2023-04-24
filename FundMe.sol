//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// get withdraws 
//Withdraw fund
//Set minimum funding value in USD

import "./PriceConverter.sol"

contract FundMe {

    uint256 public min_usd = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;


    function fund() public payable {
        //want to be able to set a mininium fund amount in USD
        //1. How do we send ETH to this contract
        require(getConversionRate(msg.value) >= min_usd, "Didn't send enough");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }


    // function withdraw(){

    // }
}