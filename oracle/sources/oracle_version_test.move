module oracle::oracle_version_test {
    use oracle::oracle_version as V;
    use oracle::oracle_constants as C;

    #[test]
    public fun version_ok() {
        assert!(V::this_version() == C::version(), 1);
        assert!(V::next_version() == C::version() + 1, 2);
    }

    #[test]
    public fun pre_check_version_ok() {
        V::pre_check_version(C::version());
    }

    #[test]
    #[expected_failure(abort_code = 6200)]
    public fun pre_check_version_fail() {
        V::pre_check_version(C::version() + 2);
    }
}

