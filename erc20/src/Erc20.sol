// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// import {ERC20} from "openzeppelin-contracts/token/ERC20/ERC20.sol";
import {IERC20} from "openzeppelin-contracts/token/ERC20/IERC20.sol";

contract ERC20Basic is IERC20 {
    string public constant name = "SPHToken";
    string public constant symbol = "SPH";
    uint8 public constant decimals = 18;

    mapping(address => uint256) balances;

    mapping(address => mapping(address => uint256)) allowed;

    uint256 totalSupply_ = 1024 ether;

    constructor() {
        balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public view override returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(
        address tokenOwner
    ) public view override returns (uint256) {
        return balances[tokenOwner];
    }

    function transfer(
        address receiver,
        uint256 numTokens
    ) public override returns (bool) {
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender] - numTokens;
        balances[receiver] = balances[receiver] + numTokens;
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }

    function approve(
        address delegate,
        uint256 numTokens
    ) public override returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    function allowance(
        address owner,
        address delegate
    ) public view override returns (uint) {
        return allowed[owner][delegate];
    }

    function transferFrom(
        address owner,
        address buyer,
        uint256 numTokens
    ) public override returns (bool) {
        require(numTokens <= balances[owner]);
        require(numTokens <= allowed[owner][msg.sender]);

        balances[owner] = balances[owner] - numTokens;
        allowed[owner][msg.sender] = allowed[owner][msg.sender] - numTokens;
        balances[buyer] = balances[buyer] + numTokens;
        emit Transfer(owner, buyer, numTokens);
        return true;
    }
}

// contract DEX {
//     event Bought(uint256 amount);
//     event Sold(uint256 amount);

//     IERC20 public token;

//     constructor() {
//         token = new ERC20Basic();
//     }

//     function buy() public payable {
//         uint256 amountTobuy = msg.value;
//         uint256 dexBalance = token.balanceOf(address(this));
//         require(amountTobuy > 0, "You need to send some ether");
//         require(amountTobuy <= dexBalance, "Not enough tokens in the reserve");
//         token.transfer(msg.sender, amountTobuy);
//         emit Bought(amountTobuy);
//     }

//     function sell(uint256 amount) public {
//         require(amount > 0, "You need to sell at least some tokens");
//         uint256 allowance = token.allowance(msg.sender, address(this));
//         require(allowance >= amount, "Check the token allowance");
//         token.transferFrom(msg.sender, address(this), amount);
//         payable(msg.sender).transfer(amount);
//         emit Sold(amount);
//     }
// }
