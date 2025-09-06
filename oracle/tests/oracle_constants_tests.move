module oracle::oracle_constants_tests {
    use oracle::oracle_constants as C;

    #[test]
    public fun test_constants_basic() {
        assert!(C::multiple() == 10000, 1);
        assert!(C::level_critical() == 0, 2);
        assert!(C::level_major() == 1, 3);
        assert!(C::level_warning() == 2, 4);
        assert!(C::level_normal() == 3, 5);
        assert!(C::primary_type() == 0, 6);
        assert!(C::secondary_type() == 1, 7);
        assert!(C::both_type() == 2, 8);
        assert!(C::default_update_interval() == 30000, 9);
        assert!(C::default_decimal_limit() == 16, 10);
        assert!(C::success() == 1, 11);
    }
}

