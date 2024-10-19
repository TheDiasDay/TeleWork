require('dotenv').config();
const { Web3 } = require('web3');

// Setup Web3 provider
const web3 = new Web3(new Web3.providers.HttpProvider(process.env.RPC_URL));

// Load Employer contract ABI and address
const employerABI = require('../blockchain/artifacts/contracts/Employer.sol/Employer.json').abi;
const employerContractAddress = process.env.EMPLOYER_CONTRACT_ADDRESS;
const employerContract = new web3.eth.Contract(employerABI, employerContractAddress);

// Load JobSeeker contract ABI and address
const jobSeekerABI = require('../blockchain/artifacts/contracts/JobSeeker.sol/JobSeeker.json').abi;
const jobSeekerContractAddress = process.env.JOBSEEKER_CONTRACT_ADDRESS;
const jobSeekerContract = new web3.eth.Contract(jobSeekerABI, jobSeekerContractAddress);

module.exports = { web3, employerContract, jobSeekerContract };