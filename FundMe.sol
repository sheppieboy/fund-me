//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// get withdraws 
//Withdraw fund
//Set minimum funding value in USD

contract FundMe {

    uint256 public min_usd = 50;

    function fund() public payable {
        //want to be able to set a mininium fund amount in USD
        //1. How do we send ETH to this contract
        require(msg.value >= min_usd, "Didn't send enough");
    }

    function getPrice() public{
        

    }

    // function getConversionRate() public {}


    // function withdraw(){

    // }
}