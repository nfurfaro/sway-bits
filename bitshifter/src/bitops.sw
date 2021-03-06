library bitops;

use core::num::*;

// const MAX_BINARY_U64 = 0b00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000_11111111_11111111_11111111_11111111_11111111_11111111_11111111_11111111;

const MAX_BINARY_U64: u64 = 0b11111111_11111111_11111111_11111111_11111111_11111111_11111111_11111111;

/// Set the nth bit of a bitmap to `0`.
pub fn turn_off_bit(bitmap: u64, n: u64) -> u64 {
    let mask = toggle_bit(MAX_BINARY_U64, n);
    bitmap & mask
}

/// Set the nth bit of a bitmap to `1`.
pub fn turn_on_bit(bitmap: u64, n: u64) -> u64 {
    let mask = toggle_bit(0u64, n);
    bitmap & mask
}

/// Flip the nth bit in a bitmap.
pub fn toggle_bit(bitmap: u64, n:  u64) -> u64 {
    let mask = single_bit_mask(n);
    bitmap ^ mask
}

/// Query a bitmat for the state of the nth bit.
pub fn query_bit(bitmap: u64, n: u64) -> u64 {
    let mask = single_bit_mask(n);
    bitmap & mask
}

/// Set the nth bit of a bitmap to `value`
pub fn set_bit(bitmap: u64, n: u64, value: u64) -> u64 {
    let clearing_mask = turn_off_bit(MAX_BINARY_U64, n);
    let new_bitmap = bitmap & clearing_mask;
    let setting_mask = if value == 0 {
        clearing_mask
    } else {
        toggle_bit(0u64, n)
    };
    bitmap | setting_mask
}

/// Get a bitmask of `n` ones.
pub fn multi_bit_mask(n: u64) -> u64 {
    (1 << n) - 1
}

/// Get a bitmask with a single `1` at the nth position.
pub fn single_bit_mask(n: u64) -> u64 {
    1 << (n - 1)
}