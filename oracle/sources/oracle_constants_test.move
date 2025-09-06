module oracle::oracle_constants_test {
    use oracle::oracle_constants as C;

    #[test]
    public fun constants_ok() {
        assert!(C::multiple() == 10000, 1);
        assert!(C::default_update_interval() == 30000, 2);
        assert!(C::default_decimal_limit() == 16, 3);
        assert!(C::version() == 2, 4);
    }
}

