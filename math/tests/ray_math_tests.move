module math::ray_math_tests {
    use math::ray_math;

    #[test]
    public fun test_ray_and_wad_constants() {
        assert!(ray_math::ray() == 1000000000000000000000000000, 10);
        assert!(ray_math::wad() == 1000000000000000000, 11);
        assert!(ray_math::half_ray() == ray_math::ray() / 2, 12);
        assert!(ray_math::half_wad() == ray_math::wad() / 2, 13);
    }

    #[test]
    public fun test_ray_mul_identity_and_zero() {
        let x: u256 = 123456789;
        assert!(ray_math::ray_mul(x, ray_math::ray()) == x, 20);
        assert!(ray_math::ray_mul(0, x) == 0, 21);
        assert!(ray_math::ray_mul(x, 0) == 0, 22);
    }

    #[test]
    public fun test_wad_mul_identity_and_zero() {
        let x: u256 = 123456789;
        assert!(ray_math::wad_mul(x, ray_math::wad()) == x, 30);
        assert!(ray_math::wad_mul(0, x) == 0, 31);
        assert!(ray_math::wad_mul(x, 0) == 0, 32);
    }

    #[test]
    public fun test_wad_div_identity() {
        let x: u256 = 987654321;
        assert!(ray_math::wad_div(x, ray_math::wad()) == x, 40);
    }

    #[test]
    public fun test_ray_div_identity() {
        let x: u256 = 987654321;
        assert!(ray_math::ray_div(x, ray_math::ray()) == x, 50);
    }

    #[test]
    public fun test_ray_wad_conversion_roundtrip() {
        let a: u256 = 123456789012345678;
        // a is in wad; convert to ray then back to wad
        let r = ray_math::wad_to_ray(a);
        let w = ray_math::ray_to_wad(r);
        assert!(w == a, 60);
    }

    #[test]
    public fun test_ray_to_wad_rounding_half_up() {
        // Construct value halfway between two wad units in ray space
        // w = 1 wad => ray = 1 * 1e9
        let one_wad = ray_math::wad();
        let one_wad_in_ray = ray_math::wad_to_ray(one_wad);
        // Add half of the ratio (1e9/2) to force round up
        let half_ratio = 1000000000 / 2;
        let rounded = ray_math::ray_to_wad(one_wad_in_ray + half_ratio);
        assert!(rounded == one_wad + 1, 70);
    }

    #[test]
    #[expected_failure(abort_code = 1103)]
    public fun test_ray_div_by_zero() {
        let _ = ray_math::ray_div(1, 0);
    }

    #[test]
    #[expected_failure(abort_code = 1103)]
    public fun test_wad_div_by_zero() {
        let _ = ray_math::wad_div(1, 0);
    }
}

