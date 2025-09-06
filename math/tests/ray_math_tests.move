module math::ray_math_tests {
    use math::ray_math;

    const E_ASSERT: u64 = 99001;

    #[test]
    fun test_wad_identity_mul_div() {
        let one_wad = ray_math::wad();

        let a1: u256 = 0u256;
        let a2: u256 = 1u256;
        let a3: u256 = 1234567890123456789u256; // < 1e19
        let a4: u256 = 987654321987654321u256;  // < 1e19

        assert!(ray_math::wad_mul(a1, one_wad) == a1, E_ASSERT);
        assert!(ray_math::wad_mul(a2, one_wad) == a2, E_ASSERT);
        assert!(ray_math::wad_mul(a3, one_wad) == a3, E_ASSERT);
        assert!(ray_math::wad_mul(a4, one_wad) == a4, E_ASSERT);

        assert!(ray_math::wad_div(a1, one_wad) == a1, E_ASSERT);
        assert!(ray_math::wad_div(a2, one_wad) == a2, E_ASSERT);
        assert!(ray_math::wad_div(a3, one_wad) == a3, E_ASSERT);
        assert!(ray_math::wad_div(a4, one_wad) == a4, E_ASSERT);
    }

    #[test]
    fun test_wad_ray_roundtrip_exact() {
        let w = 123456789u256 * 10000000000000000u256; // 123456789 * 1e16 is divisible by 1e9 factor
        // ray -> wad
        let r = ray_math::wad_to_ray(w);
        let back = ray_math::ray_to_wad(r);
        assert!(back == w, E_ASSERT);
    }

    #[test]
    fun test_ray_wad_conversion_bias_bounds() {
        // For arbitrary ray value, ray_to_wad is half-up; bias bounded by 0.5 * 1e9
        let r = 777777777777777777777777777u256; // arbitrary < 1e27
        let w1 = ray_math::ray_to_wad(r);
        // Convert back up and compare
        let r2 = ray_math::wad_to_ray(w1);
        // r2 should be within +/- 5e8 of r (scaled by 1)
        let half_ratio: u256 = 500000000u256; // 1e9 / 2
        if (r2 >= r) {
            assert!(r2 - r <= half_ratio, E_ASSERT);
        } else {
            assert!(r - r2 <= half_ratio, E_ASSERT);
        }
    }

    #[test]
    #[expected_failure(abort_code=1103)]
    fun test_wad_div_by_zero_panics() {
        let _ = ray_math::wad_div(1u256, 0u256);
    }
}

