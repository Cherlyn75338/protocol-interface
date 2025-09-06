module math::ray_math_test {
    use math::ray_math;
    use sui::address;

    #[test]
    public fun constants_ok() {
        let w = ray_math::wad();
        let r = ray_math::ray();
        assert!(w == 1000000000000000000u256, 1);
        assert!(r == 1000000000000000000000000000u256, 2);
        assert!(ray_math::half_wad() == w / 2u256, 3);
        assert!(ray_math::half_ray() == r / 2u256, 4);
    }

    #[test]
    public fun wad_mul_div_ok() {
        let one = ray_math::wad();
        let two = one + one;
        assert!(ray_math::wad_mul(one, one) == one, 10);
        assert!(ray_math::wad_div(one, one) == one, 11);
        assert!(ray_math::wad_div(two, two) == one, 12);
    }

    #[test]
    public fun ray_mul_div_ok() {
        let one_r = ray_math::ray();
        let two_r = one_r + one_r;
        assert!(ray_math::ray_mul(one_r, one_r) == one_r, 20);
        assert!(ray_math::ray_div(one_r, one_r) == one_r, 21);
        assert!(ray_math::ray_div(two_r, two_r) == one_r, 22);
    }

    #[test]
    public fun conversions_ok() {
        let one = ray_math::wad();
        let two = one + one;
        assert!(ray_math::ray_to_wad(ray_math::wad_to_ray(one)) == one, 30);
        assert!(ray_math::ray_to_wad(ray_math::wad_to_ray(two)) == two, 31);
    }

    #[test]
    #[expected_failure(abort_code = 1103)]
    public fun wad_div_by_zero_fails() {
        let one = ray_math::wad();
        let _ = ray_math::wad_div(one, 0u256);
    }

    #[test]
    #[expected_failure(abort_code = 1103)]
    public fun ray_div_by_zero_fails() {
        let one = ray_math::ray();
        let _ = ray_math::ray_div(one, 0u256);
    }

    #[test]
    #[expected_failure(abort_code = 1101)]
    public fun wad_mul_overflow_fails() {
        let a = address::max();
        let _ = ray_math::wad_mul(a, 2u256);
    }

    #[test]
    #[expected_failure(abort_code = 1101)]
    public fun ray_mul_overflow_fails() {
        let a = address::max();
        let _ = ray_math::ray_mul(a, 2u256);
    }

    #[test]
    #[expected_failure(abort_code = 1102)]
    public fun ray_to_wad_add_overflow_fails() {
        let a = address::max();
        let _ = ray_math::ray_to_wad(a);
    }

    #[test]
    #[expected_failure(abort_code = 1101)]
    public fun wad_to_ray_mul_overflow_fails() {
        let a = address::max();
        let _ = ray_math::wad_to_ray(a);
    }
}

