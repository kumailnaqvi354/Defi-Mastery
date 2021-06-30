pragma solidity ^0.7.3;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import './IFlashloanUser.sol';
import './FlasloanProvider.sol';

contract FlashloanUser is IFlashloanUser{
    function startFlashloan(address flashloan,uint amount,address token)external{
        FlashloanProvider(flashloan).executeFlashloan(address(this),amount,token,bytes(''));
    }

    function flashloanCallback(uint amount,address token,bytes memory data) override external {
            IERC20(token).transfer(msg.sender, amount);
            
    }
}