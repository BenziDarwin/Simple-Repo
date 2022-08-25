//SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./Interfaces/IMainSafe.sol";

contract UserContract is Ownable {
    IMainSafe internal mainSafe;
    IERC20 internal nencoin;
    uint256 public balance;
    address private user;
    event TransferApprovedAndTransferred(
        address _from,
        address _to,
        uint256 amount
    );
    event WithdrawSuccessful(address _from, uint256 amount);

    constructor(
        address mainSafeAddress,
        address tokenAddress,
        address user
    ) {
        tokenAddress = tokenAddress;
        mainSafe = IMainSafe(mainSafeAddress);
        nencoin = IERC20(tokenAddress);
        user = user;
    }

    modifier checkAndWithdraw() {
        _;
        if ((address(this).balance - balance) > 1000000000000000) {
            uint256 finalBalance = address(this).balance - balance;
            payable(address(mainSafe)).transfer(finalBalance);
        }
    }

    modifier verifyContractOwner(address user) {
        require(
            _msgSender() == user,
            "You are not authorized to use this contract!"
        );
        _;
    }

    function deposit(uint256 amount, address tokenAddress)
        external
        checkAndWithdraw
        returns (bool)
    {
        IERC20 token = IERC20(tokenAddress);
        require(amount > 0, "Low token value.");
        require(amount <= token.balanceOf(_msgSender()), "Not enough tokens.");
        token.approve(address(this), amount);
        token.transferFrom(_msgSender(), address(this), amount);
        balance = amount;
        emit TransferApprovedAndTransferred(
            _msgSender(),
            address(this),
            amount
        );

        return token.transferFrom(_msgSender(), address(this), amount);
    }

    function withdraw(uint256 amount, address tokenAddress)
        external
        verifyContractOwner(_msgSender())
    {
        IERC20 token = IERC20(tokenAddress);
        require(amount <= balance, "Not enough tokens.");
        token.transfer(_msgSender(), amount);
    }

    function checkBalance()
        external
        verifyContractOwner(_msgSender())
        returns (uint256)
    {
        return balance;
    }

    function checkBalance(address tokenAddress)
        external
        verifyContractOwner(_msgSender())
        returns (uint256)
    {
        IERC20 token = IERC20(tokenAddress);
        return token.balanceOf(_msgSender());
    }
}
