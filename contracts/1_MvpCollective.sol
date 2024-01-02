// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MvpCollectible is ERC721URIStorage {
    uint256 public tokenCounter;
    struct Sale{
        bool isForSelling;
        uint price;
    }
    uint256 internal fee;
    mapping(uint256 => Sale) public tokenIdToSell;

    constructor () ERC721("Mvp", "MVP") {
        tokenCounter = 0;
    }

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

    function setPrice(uint256 tokenId, uint price) public  {
        require(msg.sender == ownerOf(tokenId));
        tokenIdToSell[tokenId].price = price;
    }

    function getPrice(uint256 tokenId) public view  returns (uint price) {
        return tokenIdToSell[tokenId].price;
    }

    function getIsForSelling(uint256 tokenId) public view  returns (bool isForSelling) {
        return tokenIdToSell[tokenId].isForSelling;
    }

    function enableSell(uint256 tokenId) public  {
        require(msg.sender == ownerOf(tokenId));
        require(tokenIdToSell[tokenId].price > 0, "Please set price!");
        tokenIdToSell[tokenId].isForSelling = true;
    }

    function disableSell(uint256 tokenId) public  {
        require(msg.sender == ownerOf(tokenId));
        tokenIdToSell[tokenId].isForSelling = false;
    }

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
}