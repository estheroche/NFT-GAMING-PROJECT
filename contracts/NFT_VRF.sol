// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract MerlinWarTrait is ERC721, VRFConsumerBase, Ownable {
    using SafeMath for uint256;
    using Strings for string;

    bytes32 internal keyHash;
    uint256 internal fee;
    uint256 public randomResult;
    address public VRFCoordinator;
    // GOERLI: 0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D
    address public LinkToken;
    // GOERLI: 0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D

    struct Trait {
        uint256 Gold;
        uint256 Silver;
        uint256 Hammer;
        uint256 Sword;
        uint256 Shield;
        uint256 Gun;
        uint256 Arrow;
        string Bow;
    }

    Trait[] public Traits;

    mapping(bytes32 => string) requestToTraitBow;
    mapping(bytes32 => address) requestToSender;
    mapping(bytes32 => uint256) requestToTokenId;

    /**
     * Constructor inherits VRFConsumerBase
     *
     * Network: Rinkeby
     * Chainlink VRF Coordinator address: 0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D
     * LINK token address:                0x567B6fcc497386c48Cf91BA98Bea76762368F269
     * Key Hash: 0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15
     */
    constructor(
        address _VRFCoordinator,
        address _LinkToken,
        bytes32 _keyhash
    )
        public
        VRFConsumerBase(_VRFCoordinator, _LinkToken)
        ERC721("MerlinWarTrait", "D&D")
    {
        VRFCoordinator = _VRFCoordinator;
        LinkToken = _LinkToken;
        keyHash = _keyhash;
        fee = 0.1 * 10 ** 18; // 0.1 LINK
    }

    function requestNewRandomTrait(string memory Bow) public returns (bytes32) {
        require(
            LINK.balanceOf(address(this)) >= fee,
            "Not enough LINK - fill contract with faucet"
        );
        bytes32 requestId = requestRandomness(keyHash, fee);
        requestToTraitBow[requestId] = Bow;
        requestToSender[requestId] = msg.sender;
        return requestId;
    }

    function getTokenURI(uint256 tokenId) public view returns (string memory) {
        return tokenURI(tokenId);
    }

    function setTokenURI(uint256 tokenId, string memory _tokenURI) public {
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721: transfer caller is not owner nor approved"
        );
        _setTokenURI(tokenId, _tokenURI);
    }

    function fulfillRandomness(
        bytes32 requestId,
        uint256 randomNumber
    ) internal override {
        uint256 newId = Traits.length;
        uint256 Gold = (randomNumber % 100);
        uint256 Silver = ((randomNumber % 10000) / 100);
        uint256 Hammer = ((randomNumber % 1000000) / 10000);
        uint256 Sword = ((randomNumber % 100000000) / 1000000);
        uint256 Shield = ((randomNumber % 10000000000) / 100000000);
        uint256 Gun = ((randomNumber % 1000000000000) / 10000000000);
        uint256 Arrow = 0;

        Traits.push(
            Trait(
                Gold,
                Silver,
                Hammer,
                Sword,
                Shield,
                Gun,
                Arrow,
                requestToTraitBow[requestId]
            )
        );
        _safeMint(requestToSender[requestId], newId);
    }

    function getLevel(uint256 tokenId) public view returns (uint256) {
        return sqrt(Traits[tokenId].Arrow);
    }

    function getNumberOfTraits() public view returns (uint256) {
        return Traits.length;
    }

    function getTraitOverView(
        uint256 tokenId
    ) public view returns (string memory, uint256, uint256, uint256) {
        return (
            Traits[tokenId].Bow,
            Traits[tokenId].Gold +
                Traits[tokenId].Silver +
                Traits[tokenId].Hammer +
                Traits[tokenId].Sword +
                Traits[tokenId].Shield +
                Traits[tokenId].Gun,
            getLevel(tokenId),
            Traits[tokenId].Arrow
        );
    }

    function getTraitStats(
        uint256 tokenId
    )
        public
        view
        returns (uint256, uint256, uint256, uint256, uint256, uint256, uint256)
    {
        return (
            Traits[tokenId].Gold,
            Traits[tokenId].Silver,
            Traits[tokenId].Hammer,
            Traits[tokenId].Sword,
            Traits[tokenId].Shield,
            Traits[tokenId].Gun,
            Traits[tokenId].Arrow
        );
    }

    function sqrt(uint256 x) internal view returns (uint256 y) {
        uint256 z = (x + 1) / 2;
        y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
    }
}
