module math::safe_math_tests {
    use math::safe_math as sm;

    #[test]
    fun test_add_sub_mul_div_mod() {
        assert!(sm::add(1, 2) == 3, 0);
        assert!(sm::sub(5, 3) == 2, 0);
        assert!(sm::mul(0, 999) == 0, 0);
        assert!(sm::mul(2, 3) == 6, 0);
        assert!(sm::div(9, 3) == 3, 0);
        assert!(sm::mod(10, 3) == 1, 0)
    }

    #[test]
    fun test_mul_overflow_guard() {
        // Large values should still be safe in u256 range
        let a: u256 = 1000000000000000000; // 1e18
        let b: u256 = 1000000000000000000; // 1e18
        let c = sm::mul(a, b);
        // 1e36 fits well in u256
        assert!(c == 1000000000000000000000000000000000000, 0)
    }
}

