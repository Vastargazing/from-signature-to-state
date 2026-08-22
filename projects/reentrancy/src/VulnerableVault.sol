// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

/// @title VulnerableVault
/// @notice Teaching contract only. It deliberately breaks
///         checks-effects-interactions by paying ETH out before it clears the
///         caller's recorded balance. A reentrant caller sees the stale balance
///         and withdraws again. Never deploy this to a live network.
contract VulnerableVault {
    /// @notice ETH each account has deposited and not yet withdrawn.
    mapping(address => uint256) public balances;

    /// @notice Record an ETH deposit for the caller.
    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    /// @notice Pay the caller their whole balance.
    /// @dev The bug is the ordering. The external call runs while
    ///      `balances[msg.sender]` still holds the old amount, so a callback can
    ///      reenter and be paid again before the balance ever reaches zero.
    function withdraw() external {
        uint256 amount = balances[msg.sender];
        require(amount != 0, "nothing to withdraw");

        // Interaction happens before the effect: this is the vulnerability.
        (bool ok,) = msg.sender.call{value: amount}("");
        require(ok, "transfer failed");

        // Effect runs too late. By now a reentrant call may have already drained
        // the vault using the balance we are only now setting to zero.
        balances[msg.sender] = 0;
    }

    /// @notice ETH the vault actually holds, independent of internal accounting.
    function totalAssets() external view returns (uint256) {
        return address(this).balance;
    }
}
