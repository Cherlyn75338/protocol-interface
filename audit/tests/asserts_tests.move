module audit::asserts_tests {
    use audit::asserts;

    #[test]
    fun test_not_paused() {
        asserts::assert_not_paused(false)
    }

    #[test]
    fun test_non_zero() {
        asserts::assert_non_zero_u64(1);
        asserts::assert_non_zero_u256(1)
    }

    #[test]
    fun test_price_fresh_and_decimal_limit() {
        let now: u64 = 1000;
        let oracle_ts: u64 = 990;
        let max_diff: u64 = 20;
        asserts::assert_price_fresh(now, oracle_ts, max_diff);
        asserts::assert_decimal_within_limit(8, 16)
    }
}

