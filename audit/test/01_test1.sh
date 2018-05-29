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
var subscribers = [subscriber1, subscriber2, subscriber3, subscriber4, subscriber5];
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + transferAndApproveTokensMessage + " ----------");
var transferAndApproveTokensTx = [];
var i = 0;
subscribers.forEach(function(e) {
  // console.log("RESULT: " + e);
  transferAndApproveTokensTx.push(token.transfer(e, new BigNumber(20000).shift(18), {from: tokenDistributor, gas: 100000, gasPrice: defaultGasPrice}));
  transferAndApproveTokensTx.push(token.approve(subscriptionAddress, new BigNumber(20000).shift(18), {from: e, gas: 100000, gasPrice: defaultGasPrice}));
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
subscribers.forEach(function(e) {
  // console.log("RESULT: " + e);
  var _id = "0x" + web3.padLeft(web3.toHex(parseInt(i) + 1000).substring(2), 64);
  var _value = web3.toWei(parseInt(10000) + i * 100 + i % 2 + i % 3 + i % 5 + i % 7, "ether");
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
var distributeFees1_1Tx = subscription.distributeFees({from: minerAccount, gas: 1000000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
printTxData("distributeFees1_1Tx", distributeFees1_1Tx);
failIfTxStatusError(distributeFees1_1Tx, distributeFees1_Message);
printSubscriptionContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


EOF
grep "DATA: " $TEST1OUTPUT | sed "s/DATA: //" > $DEPLOYMENTDATA
cat $DEPLOYMENTDATA
grep "RESULT: " $TEST1OUTPUT | sed "s/RESULT: //" > $TEST1RESULTS
cat $TEST1RESULTS
