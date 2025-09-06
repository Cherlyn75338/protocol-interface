module math::safe_math_test {
    use math::safe_math;
    use sui::address;

    #[test]
    public fun add_sub_mul_div_mod_min_ok() {
        let a = 10u256;
        let b = 3u256;
        assert!(safe_math::add(a, b) == 13u256, 1);
        assert!(safe_math::sub(a, b) == 7u256, 2);
        assert!(safe_math::mul(a, b) == 30u256, 3);
        assert!(safe_math::div(a, b) == 3u256, 4);
        assert!(safe_math::mod(a, b) == 1u256, 5);
        assert!(safe_math::min(a, b) == b, 6);
        assert!(safe_math::min(b, a) == b, 7);
    }

    #[test]
    #[expected_failure(abort_code = 1001)]
    public fun add_overflow_fails() {
        let a = address::max();
        let _ = safe_math::add(a, 1u256);
    }

    #[test]
    #[expected_failure(abort_code = 1002)]
    public fun sub_underflow_fails() {
        let _ = safe_math::sub(0u256, 1u256);
    }

    #[test]
    #[expected_failure(abort_code = 1003)]
    public fun mul_overflow_fails() {
        let a = address::max();
        let _ = safe_math::mul(a, 2u256);
    }

    #[test]
    #[expected_failure(abort_code = 1004)]
    public fun div_by_zero_fails() {
        let _ = safe_math::div(1u256, 0u256);
    }

    #[test]
    #[expected_failure(abort_code = 1005)]
    public fun mod_by_zero_fails() {
        let _ = safe_math::mod(1u256, 0u256);
    }
}

