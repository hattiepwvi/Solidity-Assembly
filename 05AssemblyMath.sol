// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * 1、Assembly: 要手动检查溢出
 *
 *
 */

contract AssemblyMath {
    function yul_add(uint x, uint y) public pure returns (uint z) {
        // 如果 z < x 表明 z 回滚了，发生溢出的错误
        assembly {
            z := add(x, y)
            if lt(z, x) {
                revert(0, 0)
            }
        }
    }

    // 乘法溢出： z / x 是否 = y
    // iszero(eq(div(z, x), y))表示判断eq(div(z, x), y)的结果是否为0。
    // iszero(eq(div(z, x), y))的结果为真（即为1），则说明div(z, x)的结果不等于y
    function yul_mul(uint x, uint y) public pure returns (uint z) {
        assembly {
            switch x
            case 0 {
                z := 0
            }
            default {
                z := mul(x, y)
                if iszero(eq(div(z, x), y)) {
                    revert(0, 0)
                }
            }
        }
    }

    // Round to nearest multiple of b
    function yul_fixed_point_round(
        uint x,
        uint b
    ) public pure returns (uint z) {
        assembly {
            // b = 100
            // x = 90
            // z = 90 / 100 * 100 = 0, want z = 100
            // z := mul(div(x, b), b)

            let half := div(b, 2)
            z := add(x, half)
            z := mul(div(z, b), b)
            // x = 90
            // half = 50
            // z = 90 + 50 = 140
            // z = 140 / 100 * 100 = 100
        }
    }

    // underflow
    function sub(uint x, uint y) public pure returns (uint z) {
        assembly {
            if lt(x, y) {
                revert(0, 0)
            }
            z := sub(x, y)
        }
    }

    function fixed_point_mul(
        uint x,
        uint y,
        uint b
    ) public pure returns (uint z) {
        assembly {
            // 9 * 2 = 18
            // b = 100
            // x = 900
            // y = 200
            // z = 900 * 200 = 9 * b * 2 = 180000
            // 180000 / 100 = 1800 != 18

            switch x
            case 0 {
                z := 0
            }
            default {
                z := mul(x, y)
                if iszero(eq(div(z, x), y)) {
                    revert(0, 0)
                }
                z := div(z, b)
            }
        }
    }
}
