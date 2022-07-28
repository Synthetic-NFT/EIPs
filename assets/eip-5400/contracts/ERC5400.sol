// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./IERC5400.sol";

contract ERC5400 is ERC721, IERC5400 {

    mapping (uint256 => address) internal _beneficiaries;

    constructor(string memory name_, string memory symbol_)
    ERC721(name_,symbol_)
    {
    }

    /// @notice set the beneficiary of a NFT
    /// @dev The zero address indicates there is no beneficiary
    /// Throws if `tokenId` is not valid NFT
    /// @param beneficiary  The new beneficiary of the NFT
    function setBeneficiary(uint256 tokenId, address beneficiary) public override virtual{
        require(_isApprovedOrOwner(msg.sender, tokenId),"ERC721: transfer caller is not owner nor approved");
        _beneficiaries[tokenId] = beneficiary;
        emit UpdateBeneficiary(tokenId, beneficiary);
    }

    /// @notice Get the beneficiary address of an NFT, defaulted to the NFT owner
    /// @param tokenId The NFT to get the beneficiary address for
    /// @return The beneficiary address for this NFT
    function beneficiaryOf(uint256 tokenId)public view override virtual returns(address){
        address beneficiary = _beneficiaries[tokenId];
        if (beneficiary == address(0)) return ownerOf(tokenId);
        return beneficiary;
    }

    /// @dev See {IERC165-supportsInterface}.
    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return interfaceId == type(IERC5400).interfaceId || super.supportsInterface(interfaceId);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override{
        super._beforeTokenTransfer(from, to, tokenId);

        if (from != to && _beneficiaries[tokenId] != to) {
            _beneficiaries[tokenId] = to;
            emit UpdateBeneficiary(tokenId, to);
        }
    }
}
