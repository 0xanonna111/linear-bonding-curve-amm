// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract BondingCurveToken is ERC20, ReentrancyGuard {
    uint256 public constant SLOPE = 0.001 ether;
    uint256 public constant FLOOR_PRICE = 0.01 ether;

    event Minted(address indexed to, uint256 amount, uint256 cost);
    event Burned(address indexed from, uint256 amount, uint256 reward);

    constructor() ERC20("Bonded Asset", "BND") {}

    // Simplified linear integral for purchase: Cost = Area under the curve
    function calculateCost(uint256 amount) public view returns (uint256) {
        uint256 s = totalSupply();
        // Cost = integral from s to (s + amount) of (m*x + b)
        // Cost = [0.5*m*x^2 + b*x] evaluated at (s+amount) minus s
        return (amount * (2 * FLOOR_PRICE + SLOPE * (2 * s + amount))) / 2;
    }

    function buy(uint256 amount) external payable nonReentrant {
        uint256 cost = calculateCost(amount);
        require(msg.value >= cost, "Insufficient payment");
        
        _mint(msg.sender, amount);
        emit Minted(msg.sender, amount, cost);
        
        // Refund excess ETH
        if (msg.value > cost) {
            payable(msg.sender).transfer(msg.value - cost);
        }
    }

    function sell(uint256 amount) external nonReentrant {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        uint256 reward = calculateCost(amount); // Symmetric for linear
        
        _burn(msg.sender, amount);
        payable(msg.sender).transfer(reward);
        emit Burned(msg.sender, amount, reward);
    }

    receive() external payable {}
}
