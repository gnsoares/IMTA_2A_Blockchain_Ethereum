// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.8.0;

// Exploitez une faiblesse du contrat permettant à un 
// compte de retirer plus d'éther que le montant envoyé.

contract MyUnSafe2{
    mapping (address => uint) public currencyBalance;
    address winner;
    uint max=0;
    
    function balance() external view returns(uint){
        return address(this).balance;
    }
    
    function sendMoney() external payable{
        currencyBalance[msg.sender]+= msg.value;
        if (currencyBalance[msg.sender]>max) {
            winner=msg.sender;
            max= currencyBalance[msg.sender];
        }
    }

    function winnerGetsMoneyBack(address a) external{
        require(a==winner);
        payable(a).transfer(max);
    }
    
}