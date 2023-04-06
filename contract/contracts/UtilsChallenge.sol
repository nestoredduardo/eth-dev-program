// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165Checker.sol";
import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@openzeppelin/contracts/interfaces/IERC721.sol";

contract UtilsChallenge is IERC165 {
    using ERC165Checker for address;

    bytes4 public constant IID_IERC20 = type(IERC20).interfaceId;
    bytes4 public constant IID_IERC721 = type(IERC721).interfaceId;

    function supportsInterface(
        bytes4 interfaceId
    ) public view virtual override returns (bool) {
        return
            interfaceId == type(IERC165).interfaceId ||
            interfaceId == IID_IERC20 ||
            interfaceId == IID_IERC721;
    }

    function isERC20(address _address) public view returns (bool) {
        return _address.supportsInterface(IID_IERC20);
    }

    function isERC721(address _address) public view returns (bool) {
        return _address.supportsInterface(IID_IERC721);
    }
}
