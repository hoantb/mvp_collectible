pragma solidity 0.7.6;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MvpCollectible is ERC721 {
    uint256 public tokenCounter;
    struct Sale{
        bool isForSelling;
        uint256 price;
    }
    uint256 internal fee;
    address private _owner;
    mapping(uint256 => Sale) public tokenIdToSell;

    constructor () public ERC721 ("Mvp", "MVP"){
        tokenCounter = 0;
    }

    /**
    Create collectible by the caller. We default set price as 0,01
    :param: tokenURI, string. URI of a json file which contains format of file metadata
     */
    event evtCreate(address from, string URI, uint256 tokenId);
    function createCollectible(string memory tokenURI) public returns (uint256) {
        uint256 newItemId = tokenCounter;
        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
        tokenIdToSell[newItemId].isForSelling = true;
        tokenIdToSell[newItemId].price = 0.01 * 10 ** 18;
        tokenCounter = tokenCounter + 1;
        fee = 0.1 * 10 ** 18;
        emit evtCreate(msg.sender, tokenURI, newItemId);
        return newItemId;
    }

    function setPrice(uint256 tokenId, uint256 price) public  {
        require(msg.sender == ownerOf(tokenId));
        tokenIdToSell[tokenId].price = price;
    }

    function getPrice(uint256 tokenId) public returns (uint256 price) {
        price = tokenIdToSell[tokenId].price;
    }

    function getIsForSelling(uint256 tokenId) public returns (bool isForSelling) {
        isForSelling = tokenIdToSell[tokenId].isForSelling;
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


    event evtBuy(address from, address to, uint256 value);
    function buy(uint256 tokenId) public payable{
        uint price = tokenIdToSell[tokenId].price;
        //require(tokenIdToSell[tokenId].isForSelling == true, "Token is not selling");
        require(msg.value == price, "Invalid value for this token! ");
        payable(ownerOf(tokenId)).transfer(msg.value);
        _transfer(ownerOf(tokenId), msg.sender, tokenId);
        emit evtBuy(ownerOf(tokenId), msg.sender, msg.value);
    }
}
