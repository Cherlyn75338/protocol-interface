module math::ray_math_test {
    use math::ray_math;

    #[test]
    public fun test_wad_mul_div() {
        let one_wad = ray_math::wad(); // 1e18
        let two_wad = ray_math::wad() * 2;
        let mul = ray_math::wad_mul(one_wad, two_wad);
        assert!(mul == two_wad, 1);

        let div = ray_math::wad_div(two_wad, one_wad);
        assert!(div == two_wad, 2);
    }

    #[test]
    public fun test_ray_mul_div() {
        let one_ray = ray_math::ray();
        let three_ray = ray_math::ray() * 3;
        let mul = ray_math::ray_mul(one_ray, three_ray);
        assert!(mul == three_ray, 3);

        let div = ray_math::ray_div(three_ray, one_ray);
        assert!(div == three_ray, 4);
    }

    #[test]
    public fun test_ray_to_wad_and_back() {
        let x = 5u256 * ray_math::ray();
        let w = ray_math::ray_to_wad(x);
        // 5 * 1e27 -> 5 * 1e18 after conversion
        assert!(w == 5u256 * ray_math::wad(), 5);

        let back = ray_math::wad_to_ray(w);
        assert!(back == x, 6);
    }
}

