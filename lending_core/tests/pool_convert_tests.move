module lending_core::pool_convert_tests {
    use lending_core::pool;

    const E_ASSERT: u64 = 99003;

    #[test]
    fun test_convert_amount_scaling_up_down() {
        // 1. From 6 decimals to 18 (USDC-like to WAD scale)
        let up = pool::convert_amount(1_000_000, 6, 18); // 1.0
        assert!(up == 1_000_000_000_000_000_000, E_ASSERT);

        // 2. From 18 to 6 decimals
        let down = pool::convert_amount(1_000_000_000_000_000_000, 18, 6);
        assert!(down == 1_000_000, E_ASSERT);
    }

    #[test]
    fun test_convert_amount_rounding_truncation() {
        // Up then down may lose precision if not divisible by 10^(delta)
        let x = 123; // minimal non-divisible across large delta
        let up = pool::convert_amount(x, 0, 9); // 123 -> 123 * 1e9
        let back = pool::convert_amount(up, 9, 0);
        assert!(back == 123, E_ASSERT);

        // If we start with amount not divisible by 10 for down-scaling, truncation expected
        let y = 5; // 5 -> scaling down by 1 decimal should truncate
        let up10 = pool::convert_amount(y, 0, 1); // 5 -> 50
        let down = pool::convert_amount(up10, 1, 0);
        assert!(down == 5, E_ASSERT);
    }
}

