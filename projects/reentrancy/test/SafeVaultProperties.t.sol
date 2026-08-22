// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {SafeVault} from "../src/SafeVault.sol";

interface PropertyVm {
    function deal(address account, uint256 newBalance) external;
    function prank(address sender) external;
    function expectRevert() external;
}

contract SafeVaultFuzzTest {
    PropertyVm internal constant vm = PropertyVm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

    SafeVault internal vault;

    function setUp() public {
        vault = new SafeVault();
    }

    function testFuzz_DepositThenWithdraw(uint96 rawAmount, uint256 userSeed) public {
        uint256 amount = 1 + uint256(rawAmount) % 100 ether;
        address user = address(uint160(uint256(keccak256(abi.encode("fuzz-user", userSeed)))));

        vm.deal(user, amount);
        vm.prank(user);
        vault.deposit{value: amount}();

        require(vault.balances(user) == amount, "deposit liability mismatch");
        require(address(vault).balance == amount, "deposit assets mismatch");

        vm.prank(user);
        vault.withdraw();

        require(vault.balances(user) == 0, "withdraw did not clear liability");
        require(address(vault).balance == 0, "withdraw left assets behind");
        require(user.balance == amount, "withdraw paid the wrong amount");
    }

    function testFuzz_SecondWithdrawAlwaysReverts(uint96 rawAmount, uint256 userSeed) public {
        uint256 amount = 1 + uint256(rawAmount) % 100 ether;
        address user = address(uint160(uint256(keccak256(abi.encode("fuzz-user", userSeed)))));

        vm.deal(user, amount);
        vm.prank(user);
        vault.deposit{value: amount}();

        vm.prank(user);
        vault.withdraw();

        vm.expectRevert();
        vm.prank(user);
        vault.withdraw();
    }
}

contract SafeVaultHandler {
    PropertyVm internal constant vm = PropertyVm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

    SafeVault public immutable vault;

    uint256 public ghostDeposited;
    uint256 public ghostWithdrawn;
    uint256 public depositCalls;
    uint256 public withdrawCalls;

    address[4] internal actors =
        [address(0x1001), address(0x1002), address(0x1003), address(0x1004)];

    constructor(SafeVault vault_) {
        vault = vault_;
    }

    function deposit(uint256 actorSeed, uint96 rawAmount) external {
        address actor = actors[actorSeed % actors.length];
        uint256 amount = 1 + uint256(rawAmount) % 10 ether;

        vm.deal(actor, amount);
        vm.prank(actor);
        vault.deposit{value: amount}();

        ghostDeposited += amount;
        depositCalls += 1;
    }

    function withdraw(uint256 actorSeed) external {
        address actor = actors[actorSeed % actors.length];
        uint256 amount = vault.balances(actor);

        if (amount == 0) return;

        vm.prank(actor);
        vault.withdraw();

        ghostWithdrawn += amount;
        withdrawCalls += 1;
    }

    function actorCount() external view returns (uint256) {
        return actors.length;
    }

    function actorAt(uint256 index) external view returns (address) {
        return actors[index];
    }
}

abstract contract MinimalInvariantTarget {
    struct FuzzSelector {
        address addr;
        bytes4[] selectors;
    }

    struct FuzzArtifactSelector {
        string artifact;
        bytes4[] selectors;
    }

    struct FuzzInterface {
        address addr;
        string[] artifacts;
    }

    address[] internal targetedContracts;

    function targetContract(address target) internal {
        targetedContracts.push(target);
    }

    function targetContracts() external view returns (address[] memory) {
        return targetedContracts;
    }

    function excludeContracts() external pure returns (address[] memory empty) {}

    function targetSenders() external pure returns (address[] memory empty) {}

    function excludeSenders() external pure returns (address[] memory empty) {}

    function targetArtifacts() external pure returns (string[] memory empty) {}

    function excludeArtifacts() external pure returns (string[] memory empty) {}

    function targetArtifactSelectors()
        external
        pure
        returns (FuzzArtifactSelector[] memory empty)
    {}

    function targetSelectors() external pure returns (FuzzSelector[] memory empty) {}

    function excludeSelectors() external pure returns (FuzzSelector[] memory empty) {}

    function targetInterfaces() external pure returns (FuzzInterface[] memory empty) {}
}

contract SafeVaultInvariantTest is MinimalInvariantTarget {
    SafeVault internal vault;
    SafeVaultHandler internal handler;

    function setUp() public {
        vault = new SafeVault();
        handler = new SafeVaultHandler(vault);
        targetContract(address(handler));
    }

    function invariant_AssetsEqualRecordedLiabilities() public view {
        uint256 liabilities;

        for (uint256 i = 0; i < handler.actorCount(); i++) {
            liabilities += vault.balances(handler.actorAt(i));
        }

        require(address(vault).balance == liabilities, "assets and liabilities diverged");
    }

    function invariant_GhostFlowMatchesVaultBalance() public view {
        uint256 netDeposits = handler.ghostDeposited() - handler.ghostWithdrawn();
        require(address(vault).balance == netDeposits, "ghost flow and assets diverged");
    }
}
