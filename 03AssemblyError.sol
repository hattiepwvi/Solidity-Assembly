// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * 1、报错
 * revert(p, s):
 *    - tell evm which parts of memory to return: encode error message; p 和 s 都 = 0 是没有具体的错误代码和错误信息
 *
 * @notice
 */

contract AssemblyError {
    function yul_revert(uint x) public pure {
        assembly {
            // revert(p, s) - end execution
            //                revert state changes
            //                return data mem[p…(p+s))
            if gt(x, 10) {
                revert(0, 0)
            }
        }
    }
}
