use anchor_lang::prelude::*;

pub mod vault;

declare_id!("Fg6PaFpoGXkYsidMpWxTWqoz2XXZTmYFGvT9h1pZ2uY");

pub fn record_withdrawal(ctx: Context<vault::Withdraw>, amount: u64) -> Result<()> {
    ctx.accounts.vault.total_withdrawn = ctx
        .accounts
        .vault
        .total_withdrawn
        .checked_add(amount)
        .ok_or(ProgramError::ArithmeticOverflow)?;
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::vault::{EXTERNAL_PROGRAM_ID, Vault, VaultError, Withdraw, WithdrawBumps};
    use anchor_lang::{Accounts, error::Error};
    use std::collections::BTreeSet;

    #[derive(Clone, Copy)]
    struct HostileCase {
        authority_key: Pubkey,
        authority_signed: bool,
        stored_authority: Pubkey,
        mint_key: Pubkey,
        stored_mint: Pubkey,
        external_owner: Pubkey,
        vault_owner: Pubkey,
        corrupt_pda: bool,
    }

    impl HostileCase {
        fn valid() -> Self {
            Self {
                authority_key: Pubkey::new_from_array([1; 32]),
                authority_signed: true,
                stored_authority: Pubkey::new_from_array([1; 32]),
                mint_key: Pubkey::new_from_array([2; 32]),
                stored_mint: Pubkey::new_from_array([2; 32]),
                external_owner: EXTERNAL_PROGRAM_ID,
                vault_owner: ID,
                corrupt_pda: false,
            }
        }
    }

    fn validate(case: HostileCase) -> anchor_lang::Result<()> {
        let (derived_vault, bump) = Pubkey::find_program_address(
            &[
                b"vault",
                case.stored_authority.as_ref(),
                case.stored_mint.as_ref(),
            ],
            &ID,
        );
        let vault_key = if case.corrupt_pda {
            Pubkey::new_from_array([8; 32])
        } else {
            derived_vault
        };
        let vault = Vault {
            authority: case.stored_authority,
            mint: case.stored_mint,
            bump,
            total_withdrawn: 0,
        };
        let mut vault_data = Vec::new();
        vault.try_serialize(&mut vault_data)?;

        let infos = vec![
            account_info(vault_key, case.vault_owner, false, true, vault_data),
            account_info(
                case.authority_key,
                Pubkey::default(),
                case.authority_signed,
                false,
                vec![],
            ),
            account_info(
                Pubkey::new_from_array([3; 32]),
                case.external_owner,
                false,
                true,
                vec![],
            ),
            account_info(case.mint_key, Pubkey::default(), false, false, vec![]),
        ];
        let mut remaining: &'static [AccountInfo<'static>] = Box::leak(infos.into_boxed_slice());
        let mut bumps = WithdrawBumps::default();
        let mut reallocs = BTreeSet::new();

        Withdraw::try_accounts(&ID, &mut remaining, &[], &mut bumps, &mut reallocs).map(|_| ())
    }

    fn account_info(
        key: Pubkey,
        owner: Pubkey,
        is_signer: bool,
        is_writable: bool,
        data: Vec<u8>,
    ) -> AccountInfo<'static> {
        AccountInfo::new(
            Box::leak(Box::new(key)),
            is_signer,
            is_writable,
            Box::leak(Box::new(1_000_000_u64)),
            Box::leak(data.into_boxed_slice()),
            Box::leak(Box::new(owner)),
            false,
        )
    }

    fn assert_anchor_error(error: Error, expected_name: &str) {
        let Error::AnchorError(error) = error else {
            panic!("expected Anchor error, got {error:?}");
        };
        assert_eq!(error.error_name, expected_name);
    }

    #[test]
    fn valid_accounts_reach_the_handler_boundary() {
        validate(HostileCase::valid()).unwrap();
    }

    #[test]
    fn rejects_an_authority_that_did_not_sign() {
        let mut case = HostileCase::valid();
        case.authority_signed = false;

        assert_anchor_error(validate(case).unwrap_err(), "AccountNotSigner");
    }

    #[test]
    fn rejects_a_substituted_authority() {
        let mut case = HostileCase::valid();
        case.authority_key = Pubkey::new_from_array([4; 32]);

        assert_anchor_error(validate(case).unwrap_err(), "WrongAuthority");
    }

    #[test]
    fn rejects_a_lookalike_vault_at_the_wrong_pda() {
        let mut case = HostileCase::valid();
        case.corrupt_pda = true;

        assert_anchor_error(validate(case).unwrap_err(), "ConstraintSeeds");
    }

    #[test]
    fn rejects_vault_data_owned_by_another_program() {
        let mut case = HostileCase::valid();
        case.vault_owner = Pubkey::new_from_array([5; 32]);

        assert_anchor_error(validate(case).unwrap_err(), "AccountOwnedByWrongProgram");
    }

    #[test]
    fn rejects_a_substituted_mint() {
        let mut case = HostileCase::valid();
        case.mint_key = Pubkey::new_from_array([6; 32]);

        assert_anchor_error(validate(case).unwrap_err(), "WrongMint");
    }

    #[test]
    fn rejects_an_external_record_owned_by_a_lookalike_program() {
        let mut case = HostileCase::valid();
        case.external_owner = Pubkey::new_from_array([7; 32]);

        assert_anchor_error(validate(case).unwrap_err(), "WrongExternalProgram");
    }

    #[test]
    fn custom_errors_keep_the_constraint_failure_specific() {
        assert_eq!(VaultError::WrongAuthority.name(), "WrongAuthority");
        assert_eq!(VaultError::WrongMint.name(), "WrongMint");
        assert_eq!(
            VaultError::WrongExternalProgram.name(),
            "WrongExternalProgram"
        );
    }
}
