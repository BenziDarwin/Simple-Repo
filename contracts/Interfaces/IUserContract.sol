//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

interface IUserContract {
    event TransferApprovedAndTransferred(
        address _from,
        address _to,
        uint256 amount
    );
    event WithdrawSuccessful(address _from, uint256 amount);

    function deposit(uint256 amount, address tokenAddress)
        external
        returns (bool);

    function withdraw(uint256 amount, address tokenAddress) external;
}
