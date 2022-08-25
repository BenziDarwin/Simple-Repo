//SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

interface IMainSafe {
    function users() external view returns (address[] memory);

    function noOfUsers() external view returns (uint256);

    function tokenAddress() external view returns (address);

    function addUser(address _userAccount) external;
}
