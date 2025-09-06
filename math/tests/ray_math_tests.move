module math::ray_math_tests {
    use math::ray_math::{Self as rm};

    #[test]
    fun test_constants() {
        assert!(rm::wad() == 1000000000000000000, 0);
        assert!(rm::ray() == 1000000000000000000000000000, 0);
        assert!(rm::half_wad() == rm::wad() / 2, 0);
        assert!(rm::half_ray() == rm::ray() / 2, 0)
    }

    #[test]
    fun test_wad_mul_div_identities() {
        let one_wad = rm::wad();
        // 1 * 1 = 1 (in wad)
        assert!(rm::wad_mul(one_wad, one_wad) == one_wad, 0);
        // 1 / 1 = 1 (in wad)
        assert!(rm::wad_div(one_wad, one_wad) == one_wad, 0);
        // a * 0 == 0
        assert!(rm::wad_mul(one_wad, 0) == 0, 0);
        assert!(rm::wad_mul(0, one_wad) == 0, 0)
    }

    #[test]
    fun test_ray_mul_div_identities() {
        let one_ray = rm::ray();
        assert!(rm::ray_mul(one_ray, one_ray) == one_ray, 0);
        assert!(rm::ray_div(one_ray, one_ray) == one_ray, 0);
        assert!(rm::ray_mul(one_ray, 0) == 0, 0);
        assert!(rm::ray_mul(0, one_ray) == 0, 0)
    }

    #[test]
    fun test_rounding_half_up_wad() {
        let wad = rm::wad();
        let half = rm::half_wad();
        // For values near half, rounding half up should push to next integer
        // (wad * wad + half) / wad == wad + (half / wad) == wad (since half < wad)
        assert!(rm::wad_mul(wad, wad) == wad, 0);

        // Construct a * b just below 0.5 wad => round down to 0
        let a = 1; // 1e0
        let b = wad / 3; // ~0.333... wad
        let prod = (a as u256) * b; // prod < half
        let rounded = (prod + half) / wad; // 0
        assert!(rounded == 0, 0);

        // Construct a * b just above 0.5 wad => round up to 1
        let b2 = (wad / 2) + 1; // half + 1
        let prod2 = (a as u256) * b2;
        let rounded2 = (prod2 + half) / wad;
        assert!(rounded2 == 1, 0)
    }

    #[test]
    fun test_wad_ray_conversion_roundtrip() {
        let one_wad = rm::wad();
        let one_ray = rm::ray();

        // wad->ray->wad should be >= original due to half-up on cast down
        let to_ray = rm::wad_to_ray(one_wad);
        assert!(to_ray == one_ray, 0);
        let back_to_wad = rm::ray_to_wad(to_ray);
        assert!(back_to_wad == one_wad, 0)
    }
}

