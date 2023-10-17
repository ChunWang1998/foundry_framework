// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Depositor} from "../src/Depositor.sol";
import {Receiver} from "../src/Receiver.sol";
import "forge-std/console.sol";

contract Test1 is Test {
    Depositor public depositor;
    Receiver public receiverA;
    Receiver public receiverB;

    function setUp() public {
        depositor = new Depositor();
        payable(address(depositor)).transfer(100 ether);
        receiverA = new Receiver();
        receiverB = new Receiver();
    }

    function test_Depositor_Balance() public {
        assertEq(100 ether, depositor.get_balance());
    }

    function test_Depositor_Address() public view {
        address depositor_address = depositor.get_address();
        console.log(depositor_address);
    }

    function test_Depositor_Send_To_Receiver() public {
        depositor.send_money_to(address(receiverA), 3 ether);
        assertEq(97 ether, depositor.get_balance());
        assertEq(3 ether, address(receiverA).balance);
    }

    function test_Receiver_Balance_Exceed_And_Selfconsturct() public {
        // console.log("this address:");
        // console.log(address(this));
        // console.log("the depositor:");
        // console.log(address(depositor));
        depositor.send_money_to(address(receiverA), 49 ether);
        receiverA.check_balance();
        assertEq(49 ether, address(receiverA).balance);
        depositor.send_money_to(address(receiverA), 2 ether);
        receiverA.check_balance();
        assertEq(0 ether, address(receiverA).balance);
    }

    function test_Send_small_balance() public {
        bytes4 selector = bytes4(keccak256("TooSmallBalance(uint256,address)"));
        vm.expectRevert(
            abi.encodeWithSelector(selector, 1 ether, address(depositor))
        );

        depositor.send_money_to(address(receiverA), 1 ether);
        assertEq(0 ether, address(receiverA).balance);
    }

    receive() external payable {}
}
