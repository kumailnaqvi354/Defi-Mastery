pragma solidity 0.7.3;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenOpenZeppelin1 is ERC20 {
    
    constructor() ERC20("Token Name", "TOKEN_TICKER") {}
}

contract TokenOpenZeppelin2 is ERC20 {
    // passing name and Token symbol
    constructor() ERC20("Token Name", "TOKEN_TICKER") {
        // MInting Token From current EOA
        _mint(msg.sender, 100000);
    }
}

contract TokenOpenZeppelin3 is ERC20 {
    address public admin;
    constructor() ERC20("Token Name", "TOKEN_TICKER") {
        admin = msg.sender;
    }

    function mint(address to, uint256 amount) external {
        // Checking EOA is Admin or not 
        require(msg.sender == admin, "Only Admin");
        _mint(to, amount);
    }
}



contract TokenOpenZeppelin3 is ERC20 {
    address public admin;
    constructor() ERC20("Token Name", "TOKEN_TICKER") {
        admin = msg.sender;
    }

//   creating fake token 
    function faucet(address to, uint256 amount) external {
        require(msg.sender == admin, "Only Admin");
        _mint(to, amount);
    }
}