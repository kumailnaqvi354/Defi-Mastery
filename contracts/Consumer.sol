pragma solidity 0.7.3;
import './IOracles.sol';

contract Consumer{
    IOracle public oracle;

    constructor(address _oracle){
        oracle = IOracle(_oracle);
    }

    function foo()external{
        bytes32 key = keccak256(abi.encodePacked('BTC/USD'));

        (bool results, uint timestamp,uint payload) = oracle.getData(key);
        require(results == true,'could not get price');
        require(timestamp >= block.timestamp - 2 minutes, 'price too old');
    }
}