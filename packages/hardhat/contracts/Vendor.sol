pragma solidity 0.8.4;  //Do not change the solidity version as it negativly impacts submission grading
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {

  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);
  uint256 public constant tokensPerEth = 100;

  YourToken public yourToken;

  constructor(address tokenAddress) {
    yourToken = YourToken(tokenAddress);
  }

  // ToDo: create a payable buyTokens() function:
  function buyTokens() public payable{
    uint256 _tokenValue = msg.value * tokensPerEth ;
    yourToken.transfer(msg.sender, _tokenValue);
    emit BuyTokens(msg.sender, msg.value, _tokenValue);
  }

  // ToDo: create a withdraw() function that lets the owner withdraw ETH
  function withdraw() public onlyOwner{
      payable(msg.sender).transfer(address(this).balance);
  }

  // ToDo: create a sellTokens(uint256 _amount) function:
  function sellTokens(uint256 _amount) public payable {
      yourToken.transferFrom(msg.sender, address(this), _amount);
      uint256 _ethAmount = _amount / tokensPerEth;
      payable(msg.sender).transfer(_ethAmount);
  }

}
