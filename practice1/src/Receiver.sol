// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "forge-std/console.sol";

contract Receiver {
    address internal _owner;
    event RevertReceive(address sender);
    error TooSmallBalance(uint256, address);

    constructor() {
        _owner = msg.sender;
    }

    function check_balance() public {
        if (address(this).balance > 50 ether) {
            console.log(_owner);
            payable(_owner).transfer(address(this).balance);
        }
    }

    receive() external payable {
        if (msg.value < 2 ether) {
            emit RevertReceive(msg.sender);
            revert TooSmallBalance(msg.value, msg.sender);
        }
    }
}
