module lending_core::invariants {
    use lending_core::error;
    use lending_core::constants;
    use lending_core::storage::{Self as storage, Storage};

    use oracle::oracle::{Self as oracle_mod, PriceOracle};
    use oracle::oracle_constants;
    use sui::clock::{Clock};

    // Basic amount guard
    public fun assert_amount_non_zero(amount: u64) {
        assert!(amount > 0, error::invalid_amount())
    }

    // Ensure protocol is not paused
    public fun assert_not_paused(s: &Storage) {
        let paused = storage::pause(s);
        assert!(!paused, error::paused())
    }

    // Basic asset id sanity (soft guard; existence should be validated by getters that may abort)
    public fun assert_asset_id_in_range(asset: u8) {
        let max = constants::max_number_of_reserves();
        assert!(asset < max, error::reserve_not_found())
    }

    // Guard for denominators (u256)
    public fun assert_non_zero_u256(x: u256) {
        assert!(x > 0, error::invalid_amount())
    }

    // Ceil division for u256
    public fun ceil_div_u256(a: u256, b: u256): u256 {
        assert_non_zero_u256(b);
        let r = a % b;
        if (r == 0) {
            a / b
        } else {
            a / b + 1
        }
    }

    // Indices monotonicity guard
    public fun assert_monotonic_increase(prev: u256, next: u256) {
        assert!(next >= prev, error::invalid_amount())
    }

    // Price guard: ensure price positive and decimal within limit
    // Note: This does not perform full staleness/strategy checks, which require oracle config.
    public fun assert_price_positive_and_decimal_ok(clock: &Clock, price_oracle: &mut PriceOracle, oracle_id: u8) {
        let (ok, price, _dec) = oracle_mod::get_token_price(clock, &*price_oracle, oracle_id);
        assert!(ok, error::invalid_price());
        assert!(price > 0, error::invalid_price());
        let safe_dec = oracle_mod::safe_decimal(price_oracle, oracle_id);
        let limit = oracle_constants::default_decimal_limit();
        assert!(safe_dec <= limit, error::invalid_price())
    }
}

