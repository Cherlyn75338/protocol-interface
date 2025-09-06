module lending_core::constants_and_errors_tests {
    use lending_core::constants as C;
    use lending_core::error as E;

    #[test]
    public fun test_constants_values() {
        assert!(C::seconds_per_year() == 60 * 60 * 24 * 365, 1);
        assert!(C::option_type_supply() == 1, 2);
        assert!(C::option_type_withdraw() == 2, 3);
        assert!(C::option_type_borrow() == 3, 4);
        assert!(C::option_type_repay() == 4, 5);
        assert!(C::max_number_of_reserves() == 255, 6);
        assert!(C::FlashLoanMultiple() == 10000, 7);
    }

    #[test]
    public fun test_error_code_uniqueness_segmented() {
        // spot check non-overlap segments
        assert!(E::paused() >= 1500 && E::paused() < 1600, 10);
        assert!(E::user_is_unhealthy() >= 1600 && E::user_is_unhealthy() < 1700, 11);
        assert!(E::no_more_reserves_allowed() >= 1700 && E::no_more_reserves_allowed() < 1800, 12);
        assert!(E::non_single_value() >= 1800 && E::non_single_value() < 1900, 13);
        assert!(E::required_parent_account_cap() >= 1900 && E::required_parent_account_cap() < 2000, 14);
        assert!(E::reserve_not_found() >= 2000, 15);
    }
}

