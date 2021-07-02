pragma solidity 0.7.3;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./CTokenInterface.sol";
import "./ComptrollerInteface.sol";
import "./PriceOracleInterface.sol";

contract MyDeFiProject {
    ComptrollerInteface public comptroller;
    PriceOracleInterface public priceOracle;

    constructor(address _comptroller, address _priceOracle) {
        comptroller = ComptrollerInteface(_comptroller);
        priceOracle = PriceOracleInterface(_priceOracle);
    }

    // lending Token Start
    function supply(address cTokenAddress, uint256 underlyingAmount) external {
        CTokenInterface cToken = CTokenInterface(cTokenAddress);
        address underlyingAddress = cToken.underlying();
        IERC20(underlyingAddress).approve(cTokenAddress, underlyingAmount);
        uint256 result = cToken.mint(underlyingAmount);
        require(
            result == 0,
            "cToken#mint() failed. see Compund ErrorReporter.sol for more details"
        );
    }

    function redeem(address cTokenAddress, uint256 cTokenAmount) external {
        CTokenInterface cToken = CTokenInterface(cTokenAddress);
        uint256 result = cToken.redeem(cTokenAmount);
        require(
            result == 0,
            "cToken#redeem() failed. see Compund ErrorReporter.sol for more details"
        );
    }

    // lending Token end

    // Borrowing Token Start
    function enterMarket(address cTokenAddress) external {
        address[] memory markets = new address[](1);
        markets[0] = cTokenAddress;
        uint256[] memory results = comptroller.enterMarkets(markets);
        require(
            results[0] == 0,
            "comptroller#enterMarket() failed. see Compund ErrorReporter.sol for more details"
        );
    }

    function borrow(address cTokenAddress, uint256 borrowAmount) external {
        CTokenInterface cToken = CTokenInterface(cTokenAddress);
        address underlyingAddress = cToken.underlying();
        uint256 result = cToken.borrow(borrowAmount);
        require(
            result == 0,
            "cToken#borrow() failed. see Compund ErrorReporter.sol for more details"
        );
    }

    function repayBorrow(address cTokenAddress, uint256 underlyingAmount)
        external
    {
        CTokenInterface cToken = CTokenInterface(cTokenAddress);
        address underlyingAddress = cToken.underlying();
        IERC20(underlyingAddress).approve(cTokenAddress, underlyingAmount);
        uint256 result = cToken.repayBorrow(underlyingAmount);
        require(
            result == 0,
            "cToken#repayBorrow() failed. see Compund ErrorReporter.sol for more details"
        );
    }
    
    function getMaxBorrow(address cTokenAddress)external view returns(uint) {
        (uint result,uint liquidity, uint shortfall) = comptroller.getAccountLiquidity(address(this));
      require(
            result == 0,
            "comptroller#getAccountLiquidity() failed. see Compund ErrorReporter.sol for more details"
        );
        require(shortfall == 0,'account underwater');
        require(liquidity > 0,'account does not have collateral');
        uint underlyingPrice = priceOracle.getUnderlyingPrice(cTokenAddress);
        return liquidity / underlyingPrice;
    }
// Borrowing Token End
}
