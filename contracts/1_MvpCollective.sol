// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MvpCollectible is ERC721URIStorage {
    uint256 public tokenCounter;
    struct Sale {
        bool isForSelling;
        uint price;
    }
    uint256 internal fee;
    mapping(uint256 => Sale) public tokenIdToSell;

    constructor () ERC721("Mvp", "MVP") {
        tokenCounter = 0;
    }

    /**
     * create Collectible
     */
    function createCollectible(string memory tokenURI) public returns (uint256) {
        uint256 newItemId = tokenCounter;
        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
        tokenIdToSell[newItemId].isForSelling = false;
        tokenIdToSell[newItemId].price = 0;
        tokenCounter = tokenCounter + 1;
        fee = 0.1 * 10 ** 18;
        return newItemId;
    }

    /**
     * set the price of the token
     */
    function setPrice(uint256 tokenId, uint price) public  {
        require(msg.sender == ownerOf(tokenId));
        tokenIdToSell[tokenId].price = price;
    }

    /**
     * get the price of the token
     */
    function getPrice(uint256 tokenId) public view  returns (uint price) {
        return tokenIdToSell[tokenId].price;
    }

    /**
     * get the token whether ready for selling or not
     */
    function isReadyForSelling(uint256 tokenId) public view  returns (bool isForSelling) {
        return tokenIdToSell[tokenId].isForSelling;
    }

    /**
     * Seller enable or disable selling token
     * We need to set price larger 0 before call this function
     * If enabling is called successfully then any spender can buy this token
     * without approving from the seller
     */
    function setReadyForSelling(uint256 tokenId, bool isSelling) public  {
        if (isSelling) {
            require(msg.sender == ownerOf(tokenId));
            require(tokenIdToSell[tokenId].price > 0, "Please set price!");
        }
        tokenIdToSell[tokenId].isForSelling = isSelling;
    }

    /**
     * buy a token
     * this function requeire the token is ready for selling
     * and the input of spender must be equal with the price
     * of the token
     * after tranfering token successfully, owner of the token is changed
     * and the token is not ready for selling
     * and the price is same with the previous price
     */
    event evtCompare(uint value, uint price);
    function buy(uint256 tokenId) public payable{
        uint price = tokenIdToSell[tokenId].price;
        emit evtCompare(msg.value, price);
        require(tokenIdToSell[tokenId].isForSelling == true, "Token is not selling");
        require(msg.value == price, "Invalid value for this token! ");
        payable(ownerOf(tokenId)).transfer(msg.value);
        safeTransferFrom(ownerOf(tokenId), msg.sender, tokenId);
        tokenIdToSell[tokenId].isForSelling = false;
    }

    /**
     * Override isApprovedForAll to ignore the approving step of seller
     * because we use the isForSelling variable instead of aprroving step
     */
    function isApprovedForAll(address, address) override (ERC721, IERC721)
    public pure returns (bool)
    {
        return true;
    }
}