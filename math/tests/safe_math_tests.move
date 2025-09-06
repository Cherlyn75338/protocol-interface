module math::safe_math_tests {
    use math::safe_math;

    const E_ASSERT: u64 = 99002;

    #[test]
    fun test_add_sub_mul_div_mod_basic() {
        assert!(safe_math::add(1, 2) == 3, E_ASSERT);
        assert!(safe_math::sub(5, 3) == 2, E_ASSERT);
        assert!(safe_math::mul(7, 6) == 42, E_ASSERT);
        assert!(safe_math::div(42, 7) == 6, E_ASSERT);
        assert!(safe_math::mod(42, 5) == 2, E_ASSERT);
    }

    #[test]
    #[expected_failure(abort_code=1002)]
    fun test_sub_underflow_panics() {
        let _ = safe_math::sub(0, 1);
    }

    #[test]
    #[expected_failure(abort_code=1004)]
    fun test_div_by_zero_panics() {
        let _ = safe_math::div(1, 0);
    }

    #[test]
    #[expected_failure(abort_code=1005)]
    fun test_mod_by_zero_panics() {
        let _ = safe_math::mod(1, 0);
    }
}

