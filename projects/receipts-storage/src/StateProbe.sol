// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract StateProbe {
    uint256 public number;

    event NumberChanged(address indexed caller, uint256 previousValue, uint256 newValue);

    function setNumber(uint256 newValue) external {
        uint256 previousValue = number;
        number = newValue;

        emit NumberChanged(msg.sender, previousValue, newValue);
    }
}
