module math::safe_math_tests {
    use math::safe_math;

    #[test]
    public fun test_add_basic() {
        let a: u256 = 123;
        let b: u256 = 456;
        let c = safe_math::add(a, b);
        assert!(c == 579, 1);
    }

    #[test]
    public fun test_sub_basic() {
        let a: u256 = 456;
        let b: u256 = 123;
        let c = safe_math::sub(a, b);
        assert!(c == 333, 2);
    }

    #[test]
    public fun test_mul_basic() {
        let a: u256 = 123;
        let b: u256 = 456;
        let c = safe_math::mul(a, b);
        assert!(c == 56088, 3);
    }

    #[test]
    public fun test_div_basic() {
        let a: u256 = 56088;
        let b: u256 = 456;
        let c = safe_math::div(a, b);
        assert!(c == 123, 4);
    }

    #[test]
    public fun test_mod_basic() {
        let a: u256 = 56089;
        let b: u256 = 456;
        let c = safe_math::mod(a, b);
        assert!(c == 56089 % 456, 5);
    }

    #[test]
    #[expected_failure(abort_code = 1004)]
    public fun test_division_by_zero_traps() {
        let _ = safe_math::div(10, 0);
    }

    #[test]
    #[expected_failure(abort_code = 1005)]
    public fun test_mod_by_zero_traps() {
        let _ = safe_math::mod(10, 0);
    }
}

