// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract C {
    uint256 public number;
    address public sender;

    function setVars(uint256 newNumber) public payable {
        number = newNumber;
        sender = msg.sender;
    }
}

contract B {
    uint256 public number;
    address public sender;

    //change contract C states
    function callsetVars(uint256 newNumber, address _addr) external payable {
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("setVars(uint256)", newNumber)
        );
    }

    //change contract B states
    function delegateCallsetVars(
        uint256 newNumber,
        address _addr
    ) external payable {
        (bool success, bytes memory data) = _addr.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", newNumber)
        );
    }
}
