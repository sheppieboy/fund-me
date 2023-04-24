//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// get withdraws 
//Withdraw fund
//Set minimum funding value in USD

interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  function getRoundData(uint80 _roundId)
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );

  function latestRoundData()
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );
}

contract FundMe {

    uint256 public min_usd = 50 * 1e18;

    function fund() public payable {
        //want to be able to set a mininium fund amount in USD
        //1. How do we send ETH to this contract
        require(getConversionRate(msg.value) >= min_usd, "Didn't send enough");
    }

    function getPrice() public view returns (uint256){
        //ABI
        //Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);

        (, int256 price,,,) = priceFeed.latestRoundData();

        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount)/1e18;
        return ethAmountInUsd;
    }


    // function withdraw(){

    // }
}