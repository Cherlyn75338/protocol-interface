module utils::utils_test {
    use utils::utils;
    use sui::tx_context::{Self as tx_context, TxContext};
    use sui::coin::{Self as coin, Coin};
    use sui::balance;

    struct SUI has drop {}

    #[test]
    public fun split_coin_to_balance_ok() {
        let sender = @0xA;
        let mut ctx = tx_context::new_for_testing(sender);
        let c: Coin<SUI> = coin::mint_for_testing<SUI>(100, &mut ctx);
        let b = utils::split_coin_to_balance<SUI>(c, 40, &mut ctx);
        assert!(balance::value(&b) == 40, 1);
    }

    #[test]
    #[expected_failure(abort_code = 46000)]
    public fun split_coin_zero_amount_fails() {
        let sender = @0xA;
        let mut ctx = tx_context::new_for_testing(sender);
        let c: Coin<SUI> = coin::mint_for_testing<SUI>(10, &mut ctx);
        let _b = utils::split_coin_to_balance<SUI>(c, 0, &mut ctx);
    }

    #[test]
    #[expected_failure(abort_code = 46001)]
    public fun split_coin_insufficient_fails() {
        let sender = @0xA;
        let mut ctx = tx_context::new_for_testing(sender);
        let c: Coin<SUI> = coin::mint_for_testing<SUI>(10, &mut ctx);
        let _b = utils::split_coin_to_balance<SUI>(c, 11, &mut ctx);
    }
}

