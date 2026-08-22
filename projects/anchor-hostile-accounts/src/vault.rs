use anchor_lang::prelude::*;

pub const EXTERNAL_PROGRAM_ID: Pubkey = Pubkey::new_from_array([9; 32]);

#[account]
#[derive(InitSpace)]
pub struct Vault {
    pub authority: Pubkey,
    pub mint: Pubkey,
    pub bump: u8,
    pub total_withdrawn: u64,
}

#[derive(Accounts)]
pub struct Withdraw<'info> {
    #[account(
        mut,
        seeds = [b"vault", vault.authority.as_ref(), vault.mint.as_ref()],
        bump = vault.bump,
        has_one = authority @ VaultError::WrongAuthority,
        has_one = mint @ VaultError::WrongMint,
    )]
    pub vault: Account<'info, Vault>,
    pub authority: Signer<'info>,
    #[account(owner = EXTERNAL_PROGRAM_ID @ VaultError::WrongExternalProgram)]
    pub external_record: UncheckedAccount<'info>,
    /// CHECK: `has_one = mint` binds this address to the mint stored in `vault`.
    pub mint: UncheckedAccount<'info>,
}

#[error_code]
pub enum VaultError {
    #[msg("authority does not match the vault")]
    WrongAuthority,
    #[msg("mint does not match the vault")]
    WrongMint,
    #[msg("external record has the wrong owner program")]
    WrongExternalProgram,
}
