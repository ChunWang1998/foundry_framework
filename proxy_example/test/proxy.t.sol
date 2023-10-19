// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {C, B} from "../src/proxy.sol";
import "forge-std/console.sol";

contract ProxyTest is Test {
    B public testB;
    C public testC;

    function setUp() public {
        testB = new B();
        testC = new C();
    }

    function testsimpleCall() public {
        testB.callsetVars(10, address(testC));
        assertEq(testB.number(), 0);
        assertEq(testC.number(), 10);
    }

    function testdelegateCall() public {
        testB.delegateCallsetVars(10, address(testC));
        assertEq(testB.number(), 10);
        assertEq(testC.number(), 0);
    }
}
