// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

/// @title SafeVault
/// @notice The same interface and accounting as VulnerableVault, reordered to
///         follow checks-effects-interactions. The only change that matters is
///         the line order inside `withdraw`.
contract SafeVault {
    /// @notice ETH each account has deposited and not yet withdrawn.
    mapping(address => uint256) public balances;

    /// @notice Record an ETH deposit for the caller.
    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    /// @notice Pay the caller their whole balance, then keep nothing on the books.
    /// @dev Checks, then effects, then interactions. When the external call hands
    ///      control to the recipient, the recorded balance is already zero, so a
    ///      reentrant `withdraw` fails the `amount != 0` check. If the transfer
    ///      itself fails, `require(ok)` reverts and the zeroed balance is restored
    ///      atomically with the rest of the call frame.
    function withdraw() external {
        // Checks
        uint256 amount = balances[msg.sender];
        require(amount != 0, "nothing to withdraw");

        // Effects: commit internal state before yielding control.
        balances[msg.sender] = 0;

        // Interactions: now the untrusted call runs against consistent state.
        (bool ok,) = msg.sender.call{value: amount}("");
        require(ok, "transfer failed");
    }

    /// @notice ETH the vault actually holds, independent of internal accounting.
    function totalAssets() external view returns (uint256) {
        return address(this).balance;
    }
}
