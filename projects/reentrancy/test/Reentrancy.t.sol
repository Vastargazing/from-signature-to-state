// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {VulnerableVault} from "../src/VulnerableVault.sol";
import {SafeVault} from "../src/SafeVault.sol";
import {ReentrancyAttacker} from "../src/ReentrancyAttacker.sol";

/// @notice The slice of Foundry's cheatcode interface this lab uses. Declaring it
///         inline keeps the project dependency-free: `forge test` runs it from a
///         clean clone with no `forge install` and no network access.
interface Vm {
    function deal(address account, uint256 newBalance) external;
    function prank(address sender) external;
    function expectRevert() external;
}

contract ReentrancyTest {
    Vm internal constant vm = Vm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

    // A plain externally-owned-style address. It has no code, so the vault's ETH
    // transfer to it always succeeds and no callback runs.
    address internal victim = address(0xBEEF);

    uint256 internal constant VICTIM_DEPOSIT = 3 ether;
    uint256 internal constant ATTACK_UNIT = 1 ether;

    function assertEq(uint256 a, uint256 b, string memory reason) internal pure {
        require(a == b, reason);
    }

    function assertGt(uint256 a, uint256 b, string memory reason) internal pure {
        require(a > b, reason);
    }

    // The pre-deposited funds an honest depositor puts into a vault.
    function _seedVictim(address vaultAddr) internal {
        vm.deal(victim, VICTIM_DEPOSIT);
        vm.prank(victim);
        (bool ok,) = vaultAddr.call{value: VICTIM_DEPOSIT}(abi.encodeWithSignature("deposit()"));
        require(ok, "victim deposit failed");
    }

    /// The artificially vulnerable vault loses the honest depositor's ETH.
    function test_VulnerableVault_LosesDepositorFunds() public {
        VulnerableVault vault = new VulnerableVault();
        _seedVictim(address(vault));
        assertEq(vault.totalAssets(), VICTIM_DEPOSIT, "victim funds not present before attack");

        ReentrancyAttacker attacker = new ReentrancyAttacker(address(vault));
        vm.deal(address(this), ATTACK_UNIT);
        attacker.attack{value: ATTACK_UNIT}();

        // The vault is empty and the attacker holds every unit it drained.
        assertEq(vault.totalAssets(), 0, "vault should be fully drained");
        assertEq(
            address(attacker).balance,
            VICTIM_DEPOSIT + ATTACK_UNIT,
            "attacker did not take all funds"
        );

        // The victim's books still say 3 ether, but the vault cannot pay: the
        // pre-deposited funds are gone.
        assertEq(vault.balances(victim), VICTIM_DEPOSIT, "victim credit should look untouched");
        vm.expectRevert();
        vm.prank(victim);
        vault.withdraw();
    }

    /// A single external call fans out into several nested withdrawals.
    function test_OneCallSpawnsNestedWithdraws() public {
        VulnerableVault vault = new VulnerableVault();
        _seedVictim(address(vault));

        ReentrancyAttacker attacker = new ReentrancyAttacker(address(vault));
        vm.deal(address(this), ATTACK_UNIT);
        attacker.attack{value: ATTACK_UNIT}();

        // attack() calls withdraw() once. Everything past the first payout is a
        // reentrant call made from receive(). With a 4 ether vault and 1 ether
        // units, that is three nested withdrawals.
        assertGt(attacker.reentries(), 1, "expected several nested withdrawals");
        assertEq(attacker.reentries(), 3, "expected exactly three reentrant calls");
    }

    /// The CEI vault keeps other depositors' funds even under the same attack.
    function test_SafeVault_ProtectsOtherDepositors() public {
        SafeVault vault = new SafeVault();
        _seedVictim(address(vault));

        ReentrancyAttacker attacker = new ReentrancyAttacker(address(vault));
        vm.deal(address(this), ATTACK_UNIT);

        // The reentrant withdraw hits a zeroed balance and reverts. That failure
        // bubbles up through the transfer and rolls the whole attack back,
        // including the attacker's own seed deposit.
        vm.expectRevert();
        attacker.attack{value: ATTACK_UNIT}();

        assertEq(attacker.reentries(), 0, "callback should not have reentered");
        assertEq(address(attacker).balance, 0, "failed attack must not retain ETH");
        assertEq(vault.balances(address(attacker)), 0, "failed seed deposit must roll back");
        assertEq(vault.totalAssets(), VICTIM_DEPOSIT, "victim funds must be untouched");

        // The honest depositor can still take exactly what they put in.
        vm.prank(victim);
        vault.withdraw();
        assertEq(victim.balance, VICTIM_DEPOSIT, "victim should recover the full deposit");
        assertEq(vault.totalAssets(), 0, "vault empties out only through honest withdrawal");
    }

    /// An ordinary user deposits and withdraws from the safe vault with no drama.
    function test_SafeVault_NormalWithdrawStillWorks() public {
        SafeVault vault = new SafeVault();

        vm.deal(victim, VICTIM_DEPOSIT);
        vm.prank(victim);
        (bool ok,) =
            address(vault).call{value: VICTIM_DEPOSIT}(abi.encodeWithSignature("deposit()"));
        require(ok, "deposit failed");
        assertEq(vault.balances(victim), VICTIM_DEPOSIT, "deposit not credited");

        vm.prank(victim);
        vault.withdraw();

        assertEq(victim.balance, VICTIM_DEPOSIT, "user did not get their ETH back");
        assertEq(vault.balances(victim), 0, "balance should be cleared after withdraw");
        assertEq(vault.totalAssets(), 0, "vault should hold nothing afterward");
    }
}
