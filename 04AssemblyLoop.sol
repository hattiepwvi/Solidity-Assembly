// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AssemblyLoop {
    function yul_for_loop() public pure returns (uint z) {
        // i =0, i < 10, i++
        assembly {
            for {
                let i := 0
            } lt(i, 10) {
                i := add(i, 1)
            } {
                z := add(z, 1)
            }
        }
    }

    // while loop
    function yul_while_loop() public pure returns (uint z) {
        assembly {
            let i := 0
            for {

            } lt(i, 5) {

            } {
                i := add(i, 1)
                z := add(z, 1)
            }
        }
    }

    function sum(uint n) public pure returns (uint z) {
        assembly {
            for {
                let i := 1
            } lt(i, n) {
                i := add(i, 1)
            } {
                z := add(z, i)
            }
        }
    }

    // calculate x**n where n = 2**k
    // x > 0
    // No overflow check
    // mul(z, z): z*z
    // mod(n, 2): n%2 n除以2的余数
    function pow2k(uint x, uint n) public pure returns (uint z) {
        require(x > 0, "x = 0");
        assembly {
            if mod(n, 2) {
                revert(0, 0)
            }
            switch n
            case 0 {
                z := 1
            }
            default {
                z := x
            }
            z := x
            for {

            } gt(n, 1) {

            } {
                if mod(n, 2) {
                    revert(0, 0)
                }
                z := mul(z, z)
                n := div(n, 2)
            }
        }
    }
}
