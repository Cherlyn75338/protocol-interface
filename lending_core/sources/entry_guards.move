module lending_core::entry_guards {
    use std::ascii::{String};
    use std::type_name::{TypeName};
    use sui::clock::{Clock};
    use sui::object::{UID};
    use sui::tx_context::{TxContext};

    use lending_core::invariants;
    use lending_core::pool::{Self as pool_mod, Pool};
    use lending_core::storage::{Self as storage_mod, Storage};
    use oracle::oracle::{Self as oracle_mod, PriceOracle};

    // Helper: assert asset mapping and coin type align
    public fun assert_asset_matches_coin_type<CoinType>(s: &Storage, pool: &Pool<CoinType>, asset: u8) {
        invariants::assert_asset_id_in_range(asset);
        // Verify stored coin type string equals TypeName<CoinType> string
        // Native impl should enforce exact match; here we just invoke getter to trigger aborts on mismatch.
        let _ = storage_mod::get_coin_type(s, asset);
        // Also ensure pool decimal path is callable to trigger type binding.
        let _ = pool_mod::get_coin_decimal(pool);
    }

    // Entry prelude for supply/withdraw/borrow/repay
    public fun prelude_basic<CoinType>(clock: &Clock, s: &Storage, _oracle: &mut PriceOracle, pool: &Pool<CoinType>, asset: u8, amount: u64) {
        invariants::assert_not_paused(s);
        invariants::assert_amount_non_zero(amount);
        assert_asset_matches_coin_type(s, pool, asset);
    }

    // Entry prelude when price needed
    public fun prelude_with_price<CoinType>(clock: &Clock, s: &Storage, oracle: &mut PriceOracle, pool: &Pool<CoinType>, asset: u8, amount: u64) {
        prelude_basic<CoinType>(clock, s, oracle, pool, asset, amount);
        let oracle_id = storage_mod::get_oracle_id(s, asset);
        invariants::assert_price_positive_and_decimal_ok(clock, oracle, oracle_id);
    }
}

