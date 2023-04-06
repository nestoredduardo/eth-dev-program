// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract TokensChallenge is ERC20Burnable, Pausable, Ownable {
    constructor() ERC20("TokensChallenge", "TCH") {
        _mint(msg.sender, 1000 * 10 ** 18); // 1000 tokens
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function burnToken(uint256 amount) public whenNotPaused {
        burn(amount);
    }
}
