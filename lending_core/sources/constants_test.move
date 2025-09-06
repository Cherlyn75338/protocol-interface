module lending_core::constants_test {
    use lending_core::constants as C;

    #[test]
    public fun constants_ok() {
        let seconds_per_year = 60u256 * 60u256 * 24u256 * 365u256;
        assert!(C::seconds_per_year() == seconds_per_year, 1);
        assert!(C::option_type_supply() == 1, 2);
        assert!(C::option_type_withdraw() == 2, 3);
        assert!(C::option_type_borrow() == 3, 4);
        assert!(C::option_type_repay() == 4, 5);
        assert!(C::max_number_of_reserves() == 255, 6);
        assert!(C::version() == 6, 7);
        assert!(C::FlashLoanMultiple() == 10000, 8);
    }
}

