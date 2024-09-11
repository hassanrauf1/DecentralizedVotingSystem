// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract VotingApp {
    struct Candidate{
        string candidateName;
           uint candidateVotes;
           bool isValue; //to check if exits in mapping - true means candidate registered
    }
    address owner; //owner of contract
    uint totalCandidates = 0;
    event voteCast(address voterAddress, string message); //log to maintain voter status
    bool isVotingOpen; //if true voting is open
    mapping(address => bool) public hasVoted; //to restrict multiple votes from same address
    mapping (uint => Candidate) public candidates; //multiple candidates and voting info
    uint public startTime;
     constructor() {
        owner = msg.sender;
        isVotingOpen = true;
        startTime = block.timestamp;//CONTRACT DEPLOYMENT TIME
    }
    function elapsedMinutes() public view returns (uint) {
         // Both block.timestamp and startTime are in seconds
    // Dividing them by 1 minutes == 60 seconds to find
    // equivalent number of minutes
    return (block.timestamp - startTime);//return value is in seconds
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }
    modifier votingOpen() {
        require(isVotingOpen, "Voting is not open");
        _;
    }
    modifier votingOpenTime() {
        require(elapsedMinutes()<=60, "Vote Casting Time is Over");//vote casting time is 60secs
        _;
    }

    function closeVoting() public onlyOwner {
        isVotingOpen = false;
    }

    function vote(uint _candidateID) internal votingOpen {
        require(candidates[_candidateID].isValue==true, "Candidate Not Registered");
        require(hasVoted[msg.sender] == false, "You have already voted");
        hasVoted[msg.sender] = true; //to restrict same user casting multiple votes
        candidates[_candidateID].candidateVotes = candidates[_candidateID].candidateVotes + 1;
        emit voteCast(msg.sender,"The Vote has been Casted Succesfully");
    }
    function registerCandidate(uint _candidateID, string memory _candidateName) public onlyOwner {
        require(candidates[_candidateID].isValue==false,"Candidate Already Registered");
        Candidate memory temp = Candidate(_candidateName,0,true);
        candidates[_candidateID] = temp;
        totalCandidates++;
    }

    function getVoteCounts(uint _candidateID) external view returns (uint) {
        return candidates[_candidateID].candidateVotes;
    }
}

contract VoteCasting is VotingApp{
    VotingApp V = new VotingApp();
    function cast(uint _candidateID) public votingOpenTime{
        vote(_candidateID);

    }
    function getVoteCount(uint _candidateID) public view returns (Candidate memory) {
        return candidates[_candidateID];
    }
    function getTotalCandidates() public view returns (uint) {
        return totalCandidates;
    }

}
