// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.0;

import "./ERC5400.sol";

contract ERC5400Demo is ERC5400 {

    constructor(string memory name_, string memory symbol_)
    ERC5400(name_,symbol_)
    {
    }

    function mint(uint256 tokenId, address to) public {
        _mint(to, tokenId);
    }

}

