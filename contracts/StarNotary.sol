pragma solidity ^0.4.24;

import 'openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol';

contract StarNotary is ERC721Full {

  string private name = "HaiderGToken";
  string private symbol = "HGT";

  constructor() ERC721Full(name, symbol) public {
  }

  mapping(uint256 => string) public tokenIdToStarInfo;
  mapping(uint256 => uint256) public starsForSale;

  function createStar(string _name, uint256 _tokenId) public {
      tokenIdToStarInfo[_tokenId] = _name;

      _mint(msg.sender, _tokenId);
  }

  function putStarUpForSale(uint256 _tokenId, uint256 _price) public {
      require(this.ownerOf(_tokenId) == msg.sender);

      starsForSale[_tokenId] = _price;
  }

  function buyStar(uint256 _tokenId) public payable {
    require(starsForSale[_tokenId] > 0);

    uint256 starCost = starsForSale[_tokenId];
    address starOwner = this.ownerOf(_tokenId);
    require(msg.value >= starCost);

    _removeTokenFrom(starOwner, _tokenId);
    _addTokenTo(msg.sender, _tokenId);

    starOwner.transfer(starCost);

    if(msg.value > starCost) {
        msg.sender.transfer(msg.value - starCost);
    }
    starsForSale[_tokenId] = 0;
  }

  function lookUptokenIdToStarInfo(uint256 _tokenId) public view returns (string) {
    return tokenIdToStarInfo[_tokenId];
  }

  function exchangeStars(uint256 _tokenId1, uint256 _tokenId2) public {
    require(this.ownerOf(_tokenId1) == msg.sender);

    address star1owner = msg.sender;
    address star2owner = this.ownerOf(_tokenId2);

    _removeTokenFrom(star1owner, _tokenId1);
    _removeTokenFrom(star2owner, _tokenId2);

    _addTokenTo(star1owner, _tokenId2);
    _addTokenTo(star2owner, _tokenId1);
  }

  function transferStar(address transferTo, uint256 _tokenId) public {
    require(this.ownerOf(_tokenId) == msg.sender);

    _removeTokenFrom(msg.sender, _tokenId);
    _addTokenTo(transferTo, _tokenId);
  }

}
