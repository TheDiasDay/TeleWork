const express = require('express');
const { web3, employerContract, jobSeekerContract } = require('./web3');

const app = express();
app.use(express.json());

// Route to get data from Employer contract
app.get('/employer-data', async (req, res) => {
  try {
    const data = await employerContract.methods.someViewFunction().call();
    res.json({ result: data });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Failed to fetch data from Employer contract' });
  }
});

// Route to get data from JobSeeker contract
app.get('/jobseeker-data', async (req, res) => {
  try {
    const data = await jobSeekerContract.methods.someViewFunction().call();
    res.json({ result: data });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Failed to fetch data from JobSeeker contract' });
  }
});

// Route to send a transaction to the Employer contract
app.post('/send-employer-transaction', async (req, res) => {
  const { arg1, arg2 } = req.body;
  const account = web3.eth.accounts.privateKeyToAccount(process.env.PRIVATE_KEY);
  const tx = employerContract.methods.someWriteFunction(arg1, arg2);
  const gas = await tx.estimateGas({ from: account.address });
  const txData = tx.encodeABI();

  const signedTx = await web3.eth.accounts.signTransaction({
    to: employerContract.options.address,
    data: txData,
    gas,
  }, account.privateKey);

  try {
    const receipt = await web3.eth.sendSignedTransaction(signedTx.rawTransaction);
    res.json({ receipt });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Failed to send transaction to Employer contract' });
  }
});

// Similarly, you can add another route for the JobSeeker contract

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
