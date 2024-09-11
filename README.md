# Decentralized Voting System

A decentralized voting system built on Ethereum blockchain using Solidity smart contracts. This system allows the owner to register candidates and allows users to cast their votes in a transparent and tamper-proof manner.

## Overview

This project consists of two Solidity smart contracts:

1. **VotingApp**: This contract handles candidate registration, vote casting, and vote counting.
2. **VoteCasting**: This contract extends `VotingApp` and adds the functionality to cast votes and view the vote count.

The voting system follows these rules:
- Only the owner of the contract can register candidates.
- Voting is open for a limited time after deployment (default is 60 seconds).
- Each address can vote only once.

## Features

- **Register Candidates**: Only the contract owner can register candidates with a unique ID.
- **Cast Votes**: Users can cast votes for registered candidates while voting is open.
- **Check Vote Counts**: Anyone can view the vote count for each candidate.
- **Close Voting**: The contract owner can close voting anytime before the designated time.

- ![voting](https://github.com/user-attachments/assets/476856c6-e118-4c60-9aea-0db9f0c71756)


## Smart Contract Details

### VotingApp Contract

- **State Variables:**
  - `owner`: Address of the contract owner who can register candidates and close voting.
  - `totalCandidates`: Total number of registered candidates.
  - `isVotingOpen`: Boolean indicating if the voting is currently open.
  - `startTime`: Timestamp of contract deployment, used to control the voting period.
  - `hasVoted`: A mapping to keep track of addresses that have already voted.
  - `candidates`: A mapping to store candidate details with a unique ID.

- **Structs:**
  - `Candidate`: Represents a candidate with `candidateName`, `candidateVotes`, and `isValue` (indicating if the candidate is registered).

- **Events:**
  - `voteCast(address voterAddress, string message)`: Logs when a vote is cast.

- **Modifiers:**
  - `onlyOwner`: Restricts functions to be called only by the contract owner.
  - `votingOpen`: Ensures voting is open.
  - `votingOpenTime`: Ensures that voting is within the allowed time frame.

- **Functions:**
  - `constructor()`: Initializes the contract and sets the owner and voting start time.
  - `registerCandidate(uint _candidateID, string memory _candidateName)`: Allows the owner to register a candidate.
  - `vote(uint _candidateID)`: Allows users to cast their votes for a candidate.
  - `getVoteCounts(uint _candidateID)`: Returns the vote count for a specific candidate.
  - `closeVoting()`: Allows the owner to close the voting.

### VoteCasting Contract

- Inherits the `VotingApp` contract and provides additional functions:
  - `cast(uint _candidateID)`: Public function to cast a vote for a candidate.
  - `getVoteCount(uint _candidateID)`: Returns the details of a candidate, including the vote count.
  - `getTotalCandidates()`: Returns the total number of registered candidates.

## Installation

1. **Clone the repository**:

    ```bash
    git clone https://github.com/hassanrauf1/DecentralizedVotingSystem.git
    cd DecentralizedVotingSystem
    ```

2. **Install dependencies**:
   Make sure you have [Node.js](https://nodejs.org/) and [npm](https://www.npmjs.com/) installed.

    ```bash
    npm install
    ```

3. **Compile and deploy the contracts**:
   You can use [Remix IDE](https://remix.ethereum.org/) or Truffle to compile and deploy the contracts to an Ethereum test network like Ropsten or Rinkeby.

## Usage

1. **Register Candidates**: The contract owner should register candidates using their unique IDs and names.

2. **Start Voting**: After deployment, voting is open for a limited time (default is 60 seconds). Ensure all users are ready to vote within this time frame.

3. **Cast Votes**: Users can cast their votes by calling the `cast(uint _candidateID)` function with the ID of the candidate they wish to vote for.

4. **Check Results**: After voting is closed, results can be checked using the `getVoteCounts(uint _candidateID)` function to see the number of votes each candidate received.

5. **Close Voting**: The owner can close the voting process anytime using the `closeVoting()` function.

## Testing

To test the smart contract, you can use tools like [Truffle](https://www.trufflesuite.com/truffle), [Hardhat](https://hardhat.org/), or directly in the [Remix IDE](https://remix.ethereum.org/). Write test cases to ensure all functionalities, like candidate registration, vote casting, and result fetching, are working correctly.

## License

This project is licensed under the GPL-3.0 License.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request for any bug fixes or improvements.

## Contact

For any questions or support, please contact Eng.hassanrauf@gmail.com

---

Happy Voting!
