module oracle::oracle_version_tests {
    use oracle::oracle_version;

    #[test]
    public fun test_version_monotonic() {
        let v = oracle_version::this_version();
        assert!(oracle_version::next_version() == v + 1, 1);
    }
}

