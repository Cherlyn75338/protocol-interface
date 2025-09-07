module lending_core::invariants_test {
    use lending_core::invariants;

    #[test]
    public fun test_amount_non_zero_ok() {
        invariants::assert_amount_non_zero(1);
    }

    #[test, expected_failure]
    public fun test_amount_zero_abort() {
        invariants::assert_amount_non_zero(0);
    }

    #[test]
    public fun test_ceil_div_u256() {
        let a = 10u256;
        let b = 3u256;
        let c = invariants::ceil_div_u256(a, b);
        assert!(c == 4, 1);
    }

    #[test]
    public fun test_monotonic_increase() {
        invariants::assert_monotonic_increase(10, 10);
        invariants::assert_monotonic_increase(10, 11);
    }
}

