
pragma solidity ^0.8.10;

contract MatchBid {
    string match_id;
    uint256 public matchSartTime;
    uint maxMatchTime =  2 * 60 * 60;
    struct MatchResult {
        bool home_wins;
        bool away_wins;
    }


    struct BidDetails{
        MatchResult matchResult;
        uint256 amount;
    }
    
    address payable private owner;
    mapping(address => BidDetails) public bidders;
    address[] public addressIndices;



    constructor(string memory _match_id , uint256 _matchSartTime){
        match_id = _match_id;
        matchSartTime = _matchSartTime;
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier matchNotStarted() {
        require(block.timestamp - matchSartTime >= maxMatchTime );
        _;
    }

    function bid(MatchResult memory matchResult)  public payable {
        require(msg.value>0,"Can't bid with 0 ETH ! ");
        owner.transfer(msg.value);
        BidDetails memory bidDetails = BidDetails(matchResult , msg.value); 
        bidders[msg.sender] = bidDetails;
        addressIndices.push(msg.sender);

    }

    function endBid(address[] memory addresses, uint[] memory amounts ) public onlyOwner payable {
        uint unit = 1 ether ;

        for(uint i =0;i<addresses.length;i++) {
            payable(addresses[i]).transfer( unit * (amounts[i]) );
        }

    }
}