pragma solidity 0.7.3;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

interface ContractB{
    function deposit(uint amount)external;
    function withdraw(uint amount)external;
}

contract ContractA{
    IERC20 public token;
    ContractB public contractB;

    constructor(address _token,address _contractB){
        // passing address of token in IERC20
        token = IERC20(_token);
         // Create instance of ContractB
        contractB = ContractB(_contractB);
    } 

    function deposit(uint amount)external{
        // transfer from another account 
        token.transferFrom(msg.sender, address(this), amount);
        // approve contract to send token 
        token.approve(address(contractB), amount);
        contractB.deposit(amount);
    }

    function withdraw(uint amount) external {
        contractB.withdraw(amount);
        token.transfer(msg.sender, amount);
    }
}