module oracle::oracle_version_tests {
    use oracle::oracle_version as ov;
    use oracle::oracle_constants as oc;

    #[test]
    fun test_versions() {
        assert!(ov::this_version() == oc::version(), 0);
        assert!(ov::next_version() == oc::version() + 1, 0)
    }

    #[test]
    fun test_pre_check_version() {
        ov::pre_check_version(oc::version())
    }
}

