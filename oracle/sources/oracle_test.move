module oracle::oracle_test {
    use oracle::oracle_constants;

    #[test]
    public fun test_decimal_limit_constant() {
        let limit = oracle_constants::default_decimal_limit();
        assert!(limit >= 8 && limit <= 36, 1);
    }
}

