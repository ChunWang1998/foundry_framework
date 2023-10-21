// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {ERC20Basic} from "../src/Erc20.sol";

contract MyERC20Test is Test {
    ERC20Basic public Erc20;

    function setUp() public {
        Erc20 = new ERC20Basic();
    }
}
