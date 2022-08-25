//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./Nencoin.sol";
import "./UserContract.sol";

contract MainSafe is Ownable {
    mapping(address => UserContract) public contractToUser;
    address[] public users;
    uint256 public noOfUsers;
    address public tokenAddress;

    constructor() {
        Nencoin nencoin = new Nencoin();
        tokenAddress = address(nencoin);
        noOfUsers = 0;
    }

    function addUser(address _userAccount) external {
        UserContract newContract = new UserContract(
            address(this),
            tokenAddress,
            _userAccount
        );
        contractToUser[_userAccount] = newContract;
        users.push(_userAccount);
        noOfUsers += 1;
    }

    function stakeTokens() external {}

    function unstakeTokens() external {}

    function borrowTokens() external {}

    function payLoan() external {}

    function swapTokens() external {}

    function deposit() external payable returns (bool) {
        payable(address(this)).transferFrom(_msgSender(), msg.value);
        return true;
    }

    function withdraw() external onlyOwner returns (bool) {
        payable(address(this)).transfer(address(this).balance);
        return true;
    }
}
