// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * 1. if 没有 else
 * 1) lt：less than; gt: greater than
 * @notice
 */

contract AssemblyIf {
    function yul_if(uint x) public pure returns (uint z) {
        assembly {
            // if condition = 1 { code }
            // no else
            // if 0 { z := 99 }
            // if 1 { z := 99 }
            // 如果 x < 10 就会返回 1 (true)，就赋值 z 为 99
            if lt(x, 10) {
                z := 99
            }
        }
    }

    function yul_switch(uint x) public pure returns (uint z) {
        assembly {
            // if x = 1; default 其他情况则 z := 0
            switch x
            case 1 {
                z := 10
            }
            case 2 {
                z := 20
            }
            default {
                z := 0
            }
        }
    }

    function min(uint x, uint y) public pure returns (uint z) {
        z = y;
        assembly {
            if lt(x, y) {
                z := x
            }
        }
    }

    function max(uint x, uint y) public pure returns (uint z) {
        assembly {
            switch gt(x, y)
            case 1 {
                z := x
            }
            default {
                z := y
            }
        }
    }
}
