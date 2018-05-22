#!/bin/bash
# ----------------------------------------------------------------------------------------------
# Testing the smart contract
#
# Enjoy. (c) BokkyPooBah / Bok Consulting Pty Ltd 2017. The MIT Licence.
# ----------------------------------------------------------------------------------------------

MODE=${1:-test}

GETHATTACHPOINT=`grep ^IPCFILE= settings.txt | sed "s/^.*=//"`
PASSWORD=`grep ^PASSWORD= settings.txt | sed "s/^.*=//"`

TOKENSOURCEDIR=`grep ^TOKENSOURCEDIR= settings.txt | sed "s/^.*=//"`
SOURCEDIR=`grep ^SOURCEDIR= settings.txt | sed "s/^.*=//"`
OZSOURCEDIR=`grep ^OZSOURCEDIR= settings.txt | sed "s/^.*=//"`

TOKENSOL=`grep ^TOKENSOL= settings.txt | sed "s/^.*=//"`
TOKENJS=`grep ^TOKENJS= settings.txt | sed "s/^.*=//"`
SUBSCRIPTIONSOL=`grep ^SUBSCRIPTIONSOL= settings.txt | sed "s/^.*=//"`
SUBSCRIPTIONJS=`grep ^SUBSCRIPTIONJS= settings.txt | sed "s/^.*=//"`

DEPLOYMENTDATA=`grep ^DEPLOYMENTDATA= settings.txt | sed "s/^.*=//"`

INCLUDEJS=`grep ^INCLUDEJS= settings.txt | sed "s/^.*=//"`
TEST1OUTPUT=`grep ^TEST1OUTPUT= settings.txt | sed "s/^.*=//"`
TEST1RESULTS=`grep ^TEST1RESULTS= settings.txt | sed "s/^.*=//"`

CURRENTTIME=`date +%s`
CURRENTTIMES=`date -r $CURRENTTIME -u`

START_DATE=`echo "$CURRENTTIME+30" | bc`
START_DATE_S=`date -r $START_DATE -u`
END_DATE=`echo "$CURRENTTIME+60*1+30" | bc`
END_DATE_S=`date -r $END_DATE -u`

printf "MODE               = '$MODE'\n" | tee $TEST1OUTPUT
printf "GETHATTACHPOINT    = '$GETHATTACHPOINT'\n" | tee -a $TEST1OUTPUT
printf "PASSWORD           = '$PASSWORD'\n" | tee -a $TEST1OUTPUT
printf "TOKENSOURCEDIR     = '$TOKENSOURCEDIR'\n" | tee -a $TEST1OUTPUT
printf "SOURCEDIR          = '$SOURCEDIR'\n" | tee -a $TEST1OUTPUT
printf "OZSOURCEDIR        = '$OZSOURCEDIR'\n" | tee -a $TEST1OUTPUT
printf "TOKENSOL           = '$TOKENSOL'\n" | tee -a $TEST1OUTPUT
printf "TOKENJS            = '$TOKENJS'\n" | tee -a $TEST1OUTPUT
printf "SUBSCRIPTIONSOL    = '$SUBSCRIPTIONSOL'\n" | tee -a $TEST1OUTPUT
printf "SUBSCRIPTIONJS     = '$SUBSCRIPTIONJS'\n" | tee -a $TEST1OUTPUT
printf "DEPLOYMENTDATA     = '$DEPLOYMENTDATA'\n" | tee -a $TEST1OUTPUT
printf "INCLUDEJS          = '$INCLUDEJS'\n" | tee -a $TEST1OUTPUT
printf "TEST1OUTPUT        = '$TEST1OUTPUT'\n" | tee -a $TEST1OUTPUT
printf "TEST1RESULTS       = '$TEST1RESULTS'\n" | tee -a $TEST1OUTPUT
printf "CURRENTTIME        = '$CURRENTTIME' '$CURRENTTIMES'\n" | tee -a $TEST1OUTPUT
printf "START_DATE         = '$START_DATE' '$START_DATE_S'\n" | tee -a $TEST1OUTPUT
printf "END_DATE           = '$END_DATE' '$END_DATE_S'\n" | tee -a $TEST1OUTPUT

# Make copy of SOL file and modify start and end times ---
`cp $TOKENSOURCEDIR/$TOKENSOL .`
`cp $SOURCEDIR/DateTime.sol .`
`cp $SOURCEDIR/$SUBSCRIPTIONSOL .`
`cp -rp $OZSOURCEDIR/* .`

# --- Modify parameters ---
`perl -pi -e "s/zeppelin-solidity\/contracts\///" *.sol`
`perl -pi -e "s/totalSupply_ \= totalSupply_\.add\(TOTAL_SUPPLY\);/totalSupply_ \= TOTAL_SUPPLY;/" $TOKENSOL`
`perl -pi -e "s/balances\[_distributor\] \= balances\[_distributor\]\.add\(TOTAL_SUPPLY\);/balances\[_distributor\] \= TOTAL_SUPPLY;/" $TOKENSOL`

DIFFS1=`diff $TOKENSOURCEDIR/$TOKENSOL $TOKENSOL`
echo "--- Differences $TOKENSOURCEDIR/$TOKENSOL $TOKENSOL ---" | tee -a $TEST1OUTPUT
echo "$DIFFS1" | tee -a $TEST1OUTPUT

DIFFS1=`diff $SOURCEDIR/$SUBSCRIPTIONSOL $SUBSCRIPTIONSOL`
echo "--- Differences $SOURCEDIR/$SUBSCRIPTIONSOL $SUBSCRIPTIONSOL ---" | tee -a $TEST1OUTPUT
echo "$DIFFS1" | tee -a $TEST1OUTPUT

# for FILE in $TOKENSOL $CROWDSALESOL $VESTINGSOL
# do
#   DIFFS1=`diff $SOURCEDIR/$FILE $FILE`
#   echo "--- Differences $SOURCEDIR/$FILE $FILE ---" | tee -a $TEST1OUTPUT
#   echo "$DIFFS1" | tee -a $TEST1OUTPUT
# done

solc_0.4.23 --version | tee -a $TEST1OUTPUT

echo "var tokenOutput=`solc_0.4.23 --optimize --pretty-json --combined-json abi,bin,interface $TOKENSOL`;" > $TOKENJS
echo "var subscriptionOutput=`solc_0.4.23 --optimize --pretty-json --combined-json abi,bin,interface $SUBSCRIPTIONSOL`;" > $SUBSCRIPTIONJS

geth --verbosity 3 attach $GETHATTACHPOINT << EOF | tee -a $TEST1OUTPUT
loadScript("$TOKENJS");
loadScript("$SUBSCRIPTIONJS");
loadScript("functions.js");

var tokenAbi = JSON.parse(tokenOutput.contracts["$TOKENSOL:OrbsToken"].abi);
var tokenBin = "0x" + tokenOutput.contracts["$TOKENSOL:OrbsToken"].bin;
var subscriptionAbi = JSON.parse(subscriptionOutput.contracts["$SUBSCRIPTIONSOL:SubscriptionBilling"].abi);
var subscriptionBin = "0x" + subscriptionOutput.contracts["$SUBSCRIPTIONSOL:SubscriptionBilling"].bin;
var libDateTimeAbi = JSON.parse(subscriptionOutput.contracts["DateTime.sol:DateTime"].abi);
var libDateTimeBin = "0x" + subscriptionOutput.contracts["DateTime.sol:DateTime"].bin;

// console.log("DATA: tokenAbi=" + JSON.stringify(tokenAbi));
// console.log("DATA: tokenBin=" + JSON.stringify(tokenBin));
// console.log("DATA: subscriptionAbi=" + JSON.stringify(subscriptionAbi));
// console.log("DATA: subscriptionBin=" + JSON.stringify(subscriptionBin));
// console.log("DATA: libDateTimeAbi=" + JSON.stringify(libDateTimeAbi));
// console.log("DATA: libDateTimeBin=" + JSON.stringify(libDateTimeBin));


unlockAccounts("$PASSWORD");
printBalances();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var libDateTimeMessage = "Deploy DateTime Library";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + libDateTimeMessage + " ----------");
var libDateTimeContract = web3.eth.contract(libDateTimeAbi);
var libDateTimeTx = null;
var libDateTimeAddress = null;
var libDateTime = libDateTimeContract.new({from: contractOwnerAccount, data: libDateTimeBin, gas: 6000000, gasPrice: defaultGasPrice},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        libDateTimeTx = contract.transactionHash;
      } else {
        libDateTimeAddress = contract.address;
        addAccount(libDateTimeAddress, "DateTime Library");
        console.log("DATA: libDateTimeAddress=" + libDateTimeAddress);
      }
    }
  }
);
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(libDateTimeTx, libDateTimeMessage);
printTxData("libDateTimeAddress=" + libDateTimeAddress, libDateTimeTx);
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var tokenMessage = "Deploy Token Contract";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + tokenMessage + " ----------");
var tokenContract = web3.eth.contract(tokenAbi);
var tokenTx = null;
var tokenAddress = null;
var token = tokenContract.new(tokenDistributor, {from: contractOwnerAccount, data: tokenBin, gas: 6000000, gasPrice: defaultGasPrice},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        tokenTx = contract.transactionHash;
      } else {
        tokenAddress = contract.address;
        addAccount(tokenAddress, "Token '" + token.symbol() + "' '" + token.name() + "'");
        console.log("DATA: tokenAddress=" + tokenAddress);
        addTokenContractAddressAndAbi(tokenAddress, tokenAbi);
      }
    }
  }
);
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(tokenTx, tokenMessage);
printTxData("tokenAddress=" + tokenAddress, tokenTx);
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var subscriptionMessage = "Deploy SubscriptionBilling Contract";
var federationMembers = [federationMember1, federationMember2, federationMember3, federationMember4, federationMember5, federationMember6, federationMember7, federationMember8, federationMember9, federationMember10, federationMember11, federationMember12, federationMember13];
var minimalMonthlySubscription = new BigNumber("10").shift(18);
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + subscriptionMessage + " ----------");
// console.log("RESULT: subscriptionBin='" + subscriptionBin + "'");
var newSubscriptionBin = subscriptionBin.replace(/__DateTime\.sol\:DateTime_________________/g, libDateTimeAddress.substring(2, 42));
// console.log("RESULT: newSubscriptionBin='" + newSubscriptionBin + "'");
var subscriptionContract = web3.eth.contract(subscriptionAbi);
var subscriptionTx = null;
var subscriptionAddress = null;
var subscription = subscriptionContract.new(tokenAddress, federationMembers, minimalMonthlySubscription, {from: contractOwnerAccount, data: newSubscriptionBin, gas: 6000000, gasPrice: defaultGasPrice},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        subscriptionTx = contract.transactionHash;
      } else {
        subscriptionAddress = contract.address;
        addAccount(subscriptionAddress, "SubscriptionBilling Contract");
        addSubscriptionContractAddressAndAbi(subscriptionAddress, subscriptionAbi);
        console.log("DATA: subscriptionAddress=" + subscriptionAddress);
      }
    }
  }
);
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(subscriptionTx, subscriptionMessage);
printTxData("subscriptionAddress=" + subscriptionAddress, subscriptionTx);
printSubscriptionContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var transferAndApproveTokensMessage = "Transfer And Approve Tokens";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + transferAndApproveTokensMessage + " ----------");
var transferAndApproveTokensTx = [];
var i = 0;
federationMembers.forEach(function(e) {
  // console.log("RESULT: " + e);
  transferAndApproveTokensTx.push(token.transfer(e, new BigNumber(10000).shift(18), {from: tokenDistributor, gas: 100000, gasPrice: defaultGasPrice}));
  transferAndApproveTokensTx.push(token.approve(subscriptionAddress, new BigNumber(10000).shift(18), {from: e, gas: 100000, gasPrice: defaultGasPrice}));
  i++;
});
while (txpool.status.pending > 0) {
}
printBalances();
i = 0;
federationMembers.forEach(function(e) {
  // console.log("RESULT: " + e);
  var tx = transferAndApproveTokensTx[i];
  failIfTxStatusError(tx, transferAndApproveTokensMessage + " - " + e);
  printTxData("transferAndApproveTokens1_" + e, tx);
  i++;
});
printSubscriptionContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var subscribeMessage = "Subscribe";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + subscribeMessage + " ----------");
var subscribeTx = [];
i = 0;
federationMembers.forEach(function(e) {
  // console.log("RESULT: " + e);
  var _id = "0x" + web3.padLeft(web3.toHex(parseInt(i) + 1000).substring(2), 64);
  var _value = web3.toWei(parseInt(1000) + i * 100 + i % 2 + i % 3 + i % 5 + i % 7, "ether");
  subscribeTx.push(subscription.subscribeForCurrentMonth(_id, "" + i, _value, {from: e, gas: 300000, gasPrice: defaultGasPrice}));
  i++;
});
while (txpool.status.pending > 0) {
}
printBalances();
i = 0;
federationMembers.forEach(function(e) {
  // console.log("RESULT: " + e);
  var tx = subscribeTx[i];
  failIfTxStatusError(tx, subscribeMessage + " - " + e);
  printTxData("subscribe1_" + e, tx);
  i++;
});
printSubscriptionContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var distributeFees1_Message = "Distribute Fees";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + distributeFees1_Message + " ----------");
var distributeFees1_1Tx = subscription.distributeFees({from: contractOwnerAccount, gas: 1000000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
printTxData("distributeFees1_1Tx", distributeFees1_1Tx);
failIfTxStatusError(distributeFees1_1Tx, distributeFees1_Message);
printSubscriptionContractDetails();
printTokenContractDetails();
console.log("RESULT: ");

exit;



var fullTesting = true;

if (fullTesting) {
// -----------------------------------------------------------------------------
var whitelistMessage = "Whitelist Accounts - ac3 and ac4 for 10 ETH each";
var whitelistAccounts = [account3, account4];
var whitelistAmount = web3.toWei(10, "ether");
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + whitelistMessage + " ----------");
var whitelist1_1Tx = crowdsale.addToWhiteList(whitelistAccounts, whitelistAmount, {from: contractOwnerAccount, gas: 100000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(whitelist1_1Tx, whitelistMessage);
printTxData("whitelist1_1Tx", whitelist1_1Tx);
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");

waitUntil("crowdsale.initialTime", crowdsale.initialTime(), 0);

// -----------------------------------------------------------------------------
var sendContribution0Message = "Send Contribution #0";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + sendContribution0Message + " ----------");
var sendContribution0_1Tx = eth.sendTransaction({from: account3, to: crowdsaleAddress, gas: 400000, value: web3.toWei("0.5", "ether")});
var sendContribution0_2Tx = eth.sendTransaction({from: account4, to: crowdsaleAddress, gas: 400000, value: web3.toWei("15", "ether")});
var sendContribution0_3Tx = eth.sendTransaction({from: account5, to: crowdsaleAddress, gas: 400000, value: web3.toWei("0.5", "ether")});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(sendContribution0_1Tx, sendContribution0Message + " - ac3 0.5 ETH");
passIfTxStatusError(sendContribution0_2Tx, sendContribution0Message + " - ac4 15 ETH - Expecting failure as amount over whitelisted limit");
passIfTxStatusError(sendContribution0_3Tx, sendContribution0Message + " - ac5 0.5 ETH - Expecting failure as account not whitelisted");
printTxData("sendContribution0_1Tx", sendContribution0_1Tx);
printTxData("sendContribution0_2Tx", sendContribution0_2Tx);
printTxData("sendContribution0_3Tx", sendContribution0_3Tx);
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var sendContribution1Message = "Send Contribution #1";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + sendContribution1Message + " ----------");
var sendContribution1_1Tx = eth.sendTransaction({from: account3, to: crowdsaleAddress, gas: 400000, value: web3.toWei("0.5", "ether")});
var sendContribution1_2Tx = eth.sendTransaction({from: account4, to: crowdsaleAddress, gas: 400000, value: web3.toWei("0.5", "ether")});
var sendContribution1_3Tx = eth.sendTransaction({from: account5, to: crowdsaleAddress, gas: 400000, value: web3.toWei("0.5", "ether")});
while (txpool.status.pending > 0) {
}
printBalances();
passIfTxStatusError(sendContribution1_1Tx, sendContribution1Message + " - ac3 0.5 ETH - Expecting failure as account already contributed in 1st period");
failIfTxStatusError(sendContribution1_2Tx, sendContribution1Message + " - ac4 0.5 ETH");
passIfTxStatusError(sendContribution1_3Tx, sendContribution1Message + " - ac5 0.5 ETH - Expecting failure as account not whitelisted");
printTxData("sendContribution1_1Tx", sendContribution1_1Tx);
printTxData("sendContribution1_2Tx", sendContribution1_2Tx);
printTxData("sendContribution1_3Tx", sendContribution1_3Tx);
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


waitUntil("crowdsale.initialTime + 1 period + contribution#1 mined time", crowdsale.initialTime(), 45);


// -----------------------------------------------------------------------------
var sendContribution2Message = "Send Contribution #2 - Up to 2 x whitelisted limit";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + sendContribution2Message + " ----------");
var sendContribution2_1Tx = eth.sendTransaction({from: account3, to: crowdsaleAddress, gas: 400000, value: web3.toWei("20", "ether")});
var sendContribution2_2Tx = eth.sendTransaction({from: account4, to: crowdsaleAddress, gas: 400000, value: web3.toWei("20", "ether")});
var sendContribution2_3Tx = eth.sendTransaction({from: account5, to: crowdsaleAddress, gas: 400000, value: web3.toWei("20", "ether")});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(sendContribution2_1Tx, sendContribution2Message + " - ac3 20 ETH");
failIfTxStatusError(sendContribution2_2Tx, sendContribution2Message + " - ac4 20 ETH");
passIfTxStatusError(sendContribution2_3Tx, sendContribution2Message + " - ac5 0.5 ETH - Expecting failure as account not whitelisted");
printTxData("sendContribution2_1Tx", sendContribution2_1Tx);
printTxData("sendContribution2_2Tx", sendContribution2_2Tx);
printTxData("sendContribution2_3Tx", sendContribution2_3Tx);
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


waitUntil("crowdsale.initialTime + 2 period + contribution#2 mined time", crowdsale.initialTime(), 80);


// -----------------------------------------------------------------------------
var sendContribution3Message = "Send Contribution #3 - Outside whitelisted ETH limits";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + sendContribution3Message + " ----------");
var sendContribution3_1Tx = eth.sendTransaction({from: account3, to: crowdsaleAddress, gas: 400000, value: web3.toWei("100", "ether")});
var sendContribution3_2Tx = eth.sendTransaction({from: account4, to: crowdsaleAddress, gas: 400000, value: web3.toWei("100", "ether")});
var sendContribution3_3Tx = eth.sendTransaction({from: account5, to: crowdsaleAddress, gas: 400000, value: web3.toWei("100", "ether")});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(sendContribution3_1Tx, sendContribution3Message + " - ac3 100 ETH");
failIfTxStatusError(sendContribution3_2Tx, sendContribution3Message + " - ac4 100 ETH");
passIfTxStatusError(sendContribution3_3Tx, sendContribution3Message + " - ac5 100 ETH - Expecting failure as account not whitelisted");
printTxData("sendContribution3_1Tx", sendContribution3_1Tx);
printTxData("sendContribution3_2Tx", sendContribution3_2Tx);
printTxData("sendContribution3_3Tx", sendContribution3_3Tx);
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");
}


// -----------------------------------------------------------------------------
var finalise_Message = "Finalise And Activate Token Transfers";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + finalise_Message + " ----------");
var finalise_1Tx = crowdsale.mintToken(account11, new BigNumber("123456789").shift(18), {from: contractOwnerAccount, gas: 200000, gasPrice: defaultGasPrice});
var finalise_2Tx = crowdsale.closeSale({from: contractOwnerAccount, gas: 200000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
var finalise_3Tx = token.activate({from: contractOwnerAccount, gas: 200000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(finalise_1Tx, finalise_Message + " - crowdsale.mintToken(ac11, 123456789 tokens)");
failIfTxStatusError(finalise_2Tx, finalise_Message + " - Close sale");
failIfTxStatusError(finalise_3Tx, finalise_Message + " - Activate token transfer");
printTxData("finalise_1Tx", finalise_1Tx);
printTxData("finalise_2Tx", finalise_2Tx);
printTxData("finalise_3Tx", finalise_3Tx);
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


if (fullTesting) {
// -----------------------------------------------------------------------------
var transfer1_Message = "Move Tokens #1";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + transfer1_Message + " ----------");
var transfer1_1Tx = token.transfer(account5, "1000000000000", {from: account3, gas: 100000, gasPrice: defaultGasPrice});
var transfer1_2Tx = token.approve(account6,  "30000000000000000", {from: account4, gas: 100000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
var transfer1_3Tx = token.transferFrom(account4, account7, "30000000000000000", {from: account6, gas: 100000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
printTxData("transfer1_1Tx", transfer1_1Tx);
printTxData("transfer1_2Tx", transfer1_2Tx);
printTxData("transfer1_3Tx", transfer1_3Tx);
failIfTxStatusError(transfer1_1Tx, transfer1_Message + " - transfer 0.000001 tokens ac3 -> ac5. CHECK for movement");
failIfTxStatusError(transfer1_2Tx, transfer1_Message + " - approve 0.03 tokens ac4 -> ac6");
failIfTxStatusError(transfer1_3Tx, transfer1_Message + " - transferFrom 0.03 tokens ac4 -> ac7 by ac6. CHECK for movement");
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");
}


// -----------------------------------------------------------------------------
var deployVesting_Message = "Deploy Vesting Contract";
var vestingPeriod = 30; // 30 seconds
var tokensReleasedPerPeriod = new BigNumber(100).shift(18);
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + deployVesting_Message + " ----------");
var vestingContract = web3.eth.contract(vestingAbi);
var vestingTx = null;
var vestingAddress = null;
var vestingStart = parseInt(new Date()/1000) + 30;
var vesting = vestingContract.new(vestingBeneficiary, vestingStart, vestingPeriod, tokensReleasedPerPeriod, tokenAddress, {from: contractOwnerAccount, data: vestingBin, gas: 6000000, gasPrice: defaultGasPrice},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        vestingTx = contract.transactionHash;
      } else {
        vestingAddress = contract.address;
        addAccount(vestingAddress, "Vesting Contract");
        addVestingContractAddressAndAbi(vestingAddress, vestingAbi);
        console.log("DATA: vestingAddress=" + vestingAddress);
      }
    }
  }
);
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(vestingTx, deployVesting_Message);
printTxData("vestingAddress=" + vestingAddress, vestingTx);
printVestingContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var transferToVesting1_Message = "Transfer To Vesting Contract";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + transferToVesting1_Message + " ----------");
var transferToVesting1_1Tx = token.transfer(vestingAddress, new BigNumber(150).shift(18), {from: contractOwnerAccount, gas: 100000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
printTxData("transferToVesting1_1Tx", transferToVesting1_1Tx);
failIfTxStatusError(transferToVesting1_1Tx, transferToVesting1_Message + " - transfer 150 tokens to vesting contract");
printVestingContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


waitUntil("vesting.startFrom()", vesting.startFrom(), 15);


// -----------------------------------------------------------------------------
var releaseVesting0_Message = "Release Vesting #0";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + releaseVesting0_Message + " ----------");
var releaseVesting0_1Tx = vesting.release({from: contractOwnerAccount, gas: 200000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
printTxData("releaseVesting0_1Tx", releaseVesting0_1Tx);
passIfTxStatusError(releaseVesting0_1Tx, releaseVesting0_Message + " - Expecting failure - 0 tokens released");
printVestingContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


waitUntil("vesting.startFrom()+45", vesting.startFrom(), 45);


// -----------------------------------------------------------------------------
var releaseVesting1_Message = "Release Vesting #1";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + releaseVesting1_Message + " ----------");
var releaseVesting1_1Tx = vesting.release({from: vestingBeneficiary, gas: 200000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
printTxData("releaseVesting1_1Tx", releaseVesting1_1Tx);
failIfTxStatusError(releaseVesting1_1Tx, releaseVesting1_Message + " - Expecting 100 tokens released, executed by beneficiary");
printVestingContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


waitUntil("vesting.startFrom()+75", vesting.startFrom(), 75);


// -----------------------------------------------------------------------------
var releaseVesting2_Message = "Release Vesting #2";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + releaseVesting2_Message + " ----------");
var releaseVesting2_1Tx = vesting.release({from: contractOwnerAccount, gas: 200000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
printTxData("releaseVesting2_1Tx", releaseVesting2_1Tx);
failIfTxStatusError(releaseVesting2_1Tx, releaseVesting2_Message + " - Expecting 50 tokens released, executed by contract owner account");
printVestingContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


waitUntil("vesting.startFrom()+105", vesting.startFrom(), 105);


// -----------------------------------------------------------------------------
var releaseVesting3_Message = "Release Vesting #3";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + releaseVesting3_Message + " ----------");
console.log("RESULT: ");
var releaseVesting3_1Tx = vesting.release({from: contractOwnerAccount, gas: 200000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
printTxData("releaseVesting3_1Tx", releaseVesting3_1Tx);
passIfTxStatusError(releaseVesting3_1Tx, releaseVesting3_Message + " - Expecting failure");
printVestingContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


EOF
grep "DATA: " $TEST1OUTPUT | sed "s/DATA: //" > $DEPLOYMENTDATA
cat $DEPLOYMENTDATA
grep "RESULT: " $TEST1OUTPUT | sed "s/RESULT: //" > $TEST1RESULTS
cat $TEST1RESULTS
