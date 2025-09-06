module utils::utils_tests {
    use sui::coin::{Self, Coin};
    use sui::tx_context::{Self, TxContext};
    use utils::utils;

    // Helper to mint a test coin from zero with amount using coin::mint_for_testing
    fun mint_for_test<CoinType>(amount: u64, ctx: &mut TxContext): Coin<CoinType> {
        coin::mint_for_testing<CoinType>(amount, ctx)
    }

    #[test]
    public fun test_split_coin_success() {
        let mut ctx = tx_context::new_for_testing();
        let c: Coin<u64> = mint_for_test<u64>(1000, &mut ctx);
        let split = utils::split_coin<u64>(c, 600, &mut ctx);
        assert!(coin::value(&split) == 600, 1);
        // burn for cleanup
        coin::burn_for_testing(split);
    }

    #[test]
    #[expected_failure(abort_code = 46000)]
    public fun test_split_coin_amount_zero_fails() {
        let mut ctx = tx_context::new_for_testing();
        let c: Coin<u64> = mint_for_test<u64>(1000, &mut ctx);
        let _ = utils::split_coin<u64>(c, 0, &mut ctx);
    }

    #[test]
    #[expected_failure(abort_code = 46001)]
    public fun test_split_coin_insufficient_fails() {
        let mut ctx = tx_context::new_for_testing();
        let c: Coin<u64> = mint_for_test<u64>(500, &mut ctx);
        let _ = utils::split_coin<u64>(c, 600, &mut ctx);
    }

    #[test]
    public fun test_split_coin_to_balance_success() {
        let mut ctx = tx_context::new_for_testing();
        let c: Coin<u64> = mint_for_test<u64>(1000, &mut ctx);
        let b = utils::split_coin_to_balance<u64>(c, 400, &mut ctx);
        assert!(coin::value_for_testing(&b) == 400, 2);
        coin::burn_for_testing(b);
    }
}

