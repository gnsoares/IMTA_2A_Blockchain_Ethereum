// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.8.0;

// Exploitez deux faiblesses (différentes) pour:
// 1) une qui permet de vider le contrat de l'ether déposé par d'autres
// 2) une qui vous permet d'avoir une currencyBalance gigantesque!

contract MyUnSafe1{
    mapping (address => uint) public currencyBalance;

    function balance() external view returns(uint){
        return address(this).balance;
    }
    
    function buy() external payable{
        currencyBalance[msg.sender]+= msg.value;
    }
    
    function sell(uint amount) external{
        payable(msg.sender).transfer(amount);
        currencyBalance[msg.sender]-=amount;
    }
}