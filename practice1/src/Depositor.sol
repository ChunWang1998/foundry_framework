// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "forge-std/console.sol";

contract Depositor {
    address internal _owner;

    constructor() payable {
        _owner = msg.sender;
    }

    function get_balance() public view returns (uint) {
        return address(this).balance;
    }

    function get_address() public view returns (address) {
        return address(this);
    }

    function send_money_to(address receiver, uint amount) public {
        require(msg.sender == _owner, "sender not owner!");
        payable(receiver).transfer(amount);
    }

    receive() external payable {}
}
