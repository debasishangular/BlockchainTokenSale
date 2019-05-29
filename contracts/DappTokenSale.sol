pragma solidity >=0.4.21 <0.6.0;
import  './DappToken.sol';

contract DappTokenSale {
address admin;// state variable
DappToken public tokenContract;
uint256 public tokenPrice;

    constructor(DappToken _tokenContract,uint256 _tokenPrice) public {
     // Assign an Admin
     // Token Contract
     // Token Price in wei

     admin = msg.sender;
     tokenContract = _tokenContract;
     tokenPrice = _tokenPrice;
    }
}