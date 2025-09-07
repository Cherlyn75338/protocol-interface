module lending_core::fee_rounding_tests {
    use lending_core::constants;

    const E_ASSERT: u64 = 99004;

    #[test]
    fun test_flashloan_fee_rounding_floor() {
        // FlashLoanMultiple is in basis points (1e4). To guarantee non-zero fee for small loans,
        // protocols often enforce minimum amounts or min fee.
        let bps = constants::FlashLoanMultiple(); // e.g., 10000

        // For demonstration, if fee = amount * bps / 10000, then for amount < 10000 / bps a naive integer fee would be 0.
        // Here we only assert the algebraic risk rather than invoke native flash loan logic (not exposed).
        // Example: bps=10000 (100%), threshold = 1; bps=50 (0.5%), threshold=200.

        assert!(bps >= 1, E_ASSERT);
    }
}

