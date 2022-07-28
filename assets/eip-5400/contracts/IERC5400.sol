// SPDX-License-Identifier: CC0-1.0

pragma solidity ^0.8.0;

interface IERC5400 {
    // Logged when the beneficiary of a token assigns a new beneficiary
    event UpdateBeneficiary(uint256 indexed tokenId, address indexed beneficiary);

    /// @notice set the beneficiary of a NFT
    /// Throws if `tokenId` is not valid NFT
    /// @param beneficiary  The new beneficiary of the NFT
    function setBeneficiary(uint256 tokenId, address beneficiary) external;

    /// @notice Get the beneficiary address of an NFT, defaulted to the NFT owner
    /// @param tokenId The NFT to get the beneficiary address for
    /// @return The beneficiary address for this NFT
    function beneficiaryOf(uint256 tokenId) external view returns(address);
}
