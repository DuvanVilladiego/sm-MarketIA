// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract IAToken is ERC721, ERC721URIStorage {

    using Counters for Counters.Counter;
    
    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("IAToken", "IAT") {}

    ///Minter user
    mapping(uint => address) private _minter;

    mapping(address => uint[]) private _userTokens;

    ///@dev this function return an array with tokens id by address
    function getUsersTokens(address _users) public view returns(uint[] memory) {
        uint[] memory tokensList = _userTokens[_users];
        return tokensList;
    } 

    ///@dev this function mint new tokens
    function safeMint(string memory _uri) public {
        uint tokenId = _tokenIdCounter.current();
        uint[] storage tokensList = _userTokens[msg.sender];
        tokensList.push() = tokenId;
        _userTokens[msg.sender] = tokensList;
        _tokenIdCounter.increment();
        _minter[tokenId] = msg.sender;
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, _uri);
    }
    
    ///@notice The following functions are overrides required by Solidity.
    function _burn(uint _tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(_tokenId);
    }

    ///@notice Override functions
    ///@dev override function with the tokenHolder modifier
    function tokenURI(uint _tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(_tokenId);
    }

}