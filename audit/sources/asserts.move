module audit::asserts {
    const ERR_NOT_FRESH: u64 = 7001;
    const ERR_PAUSED: u64 = 7002;
    const ERR_ZERO: u64 = 7003;
    const ERR_DECIMAL_LIMIT: u64 = 7004;
    const ERR_INVALID_ORDERING: u64 = 7005;

    public fun assert_not_paused(paused: bool) {
        assert!(!paused, ERR_PAUSED)
    }

    public fun assert_non_zero_u64(x: u64) {
        assert!(x > 0, ERR_ZERO)
    }

    public fun assert_non_zero_u256(x: u256) {
        assert!(x > 0, ERR_ZERO)
    }

    /// Ensures oracle timestamp freshness relative to current time.
    /// Requires now >= oracle_ts and (now - oracle_ts) <= max_diff.
    public fun assert_price_fresh(now: u64, oracle_ts: u64, max_diff: u64) {
        assert!(now >= oracle_ts, ERR_INVALID_ORDERING);
        let diff = now - oracle_ts;
        assert!(diff <= max_diff, ERR_NOT_FRESH)
    }

    /// Enforce a maximum decimal precision (e.g., 16 per oracle_defaults)
    public fun assert_decimal_within_limit(decimal: u8, max_limit: u8) {
        assert!((decimal as u64) <= (max_limit as u64), ERR_DECIMAL_LIMIT)
    }
}

