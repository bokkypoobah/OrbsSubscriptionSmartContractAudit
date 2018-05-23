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
TEST2OUTPUT=`grep ^TEST2OUTPUT= settings.txt | sed "s/^.*=//"`
TEST2RESULTS=`grep ^TEST2RESULTS= settings.txt | sed "s/^.*=//"`

CURRENTTIME=`date +%s`
CURRENTTIMES=`date -r $CURRENTTIME -u`

START_DATE=`echo "$CURRENTTIME+30" | bc`
START_DATE_S=`date -r $START_DATE -u`
END_DATE=`echo "$CURRENTTIME+60*1+30" | bc`
END_DATE_S=`date -r $END_DATE -u`

printf "MODE               = '$MODE'\n" | tee $TEST2OUTPUT
printf "GETHATTACHPOINT    = '$GETHATTACHPOINT'\n" | tee -a $TEST2OUTPUT
printf "PASSWORD           = '$PASSWORD'\n" | tee -a $TEST2OUTPUT
printf "TOKENSOURCEDIR     = '$TOKENSOURCEDIR'\n" | tee -a $TEST2OUTPUT
printf "SOURCEDIR          = '$SOURCEDIR'\n" | tee -a $TEST2OUTPUT
printf "OZSOURCEDIR        = '$OZSOURCEDIR'\n" | tee -a $TEST2OUTPUT
printf "TOKENSOL           = '$TOKENSOL'\n" | tee -a $TEST2OUTPUT
printf "TOKENJS            = '$TOKENJS'\n" | tee -a $TEST2OUTPUT
printf "SUBSCRIPTIONSOL    = '$SUBSCRIPTIONSOL'\n" | tee -a $TEST2OUTPUT
printf "SUBSCRIPTIONJS     = '$SUBSCRIPTIONJS'\n" | tee -a $TEST2OUTPUT
printf "DEPLOYMENTDATA     = '$DEPLOYMENTDATA'\n" | tee -a $TEST2OUTPUT
printf "INCLUDEJS          = '$INCLUDEJS'\n" | tee -a $TEST2OUTPUT
printf "TEST2OUTPUT        = '$TEST2OUTPUT'\n" | tee -a $TEST2OUTPUT
printf "TEST2RESULTS       = '$TEST2RESULTS'\n" | tee -a $TEST2OUTPUT
printf "CURRENTTIME        = '$CURRENTTIME' '$CURRENTTIMES'\n" | tee -a $TEST2OUTPUT
printf "START_DATE         = '$START_DATE' '$START_DATE_S'\n" | tee -a $TEST2OUTPUT
printf "END_DATE           = '$END_DATE' '$END_DATE_S'\n" | tee -a $TEST2OUTPUT

# Make copy of SOL file and modify start and end times ---
`cp $SOURCEDIR/DateTime.sol .`
`cp ../test-contracts/TestDateTime.sol .`
`cp -rp $OZSOURCEDIR/* .`

# --- Modify parameters ---
`perl -pi -e "s/zeppelin-solidity\/contracts\///" *.sol`
`perl -pi -e "s/pragma solidity 0\.4\.23;/pragma solidity \^0\.4\.23;/" DateTime.sol`


solc_0.4.24 --version | tee -a $TEST2OUTPUT

echo "var testDateTimeOutput=`solc_0.4.24 --optimize --pretty-json --combined-json abi,bin,interface TestDateTime.sol`;" > TestDateTime.js

geth --verbosity 3 attach $GETHATTACHPOINT << EOF | tee -a $TEST2OUTPUT
loadScript("TestDateTime.js");
loadScript("functions.js");

var testDateTimeAbi = JSON.parse(testDateTimeOutput.contracts["TestDateTime.sol:TestDateTime"].abi);
var testDateTimeBin = "0x" + testDateTimeOutput.contracts["TestDateTime.sol:TestDateTime"].bin;
var libDateTimeAbi = JSON.parse(testDateTimeOutput.contracts["DateTime.sol:DateTime"].abi);
var libDateTimeBin = "0x" + testDateTimeOutput.contracts["DateTime.sol:DateTime"].bin;

// console.log("DATA: testDateTimeAbi=" + JSON.stringify(testDateTimeAbi));
// console.log("DATA: testDateTimeBin=" + JSON.stringify(testDateTimeBin));
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
var testDateTimeMessage = "Deploy TestDateTime Contract";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + testDateTimeMessage + " ----------");
// console.log("RESULT: testDateTimeBin='" + testDateTimeBin + "'");
var newTestDateTimeBin = testDateTimeBin.replace(/__DateTime\.sol\:DateTime_________________/g, libDateTimeAddress.substring(2, 42));
// console.log("RESULT: newTestDateTimeBin='" + newTestDateTimeBin + "'");
var testDateTimeContract = web3.eth.contract(testDateTimeAbi);
var testDateTimeTx = null;
var testDateTimeAddress = null;
var testDateTime = testDateTimeContract.new({from: contractOwnerAccount, data: newTestDateTimeBin, gas: 6000000, gasPrice: defaultGasPrice},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        testDateTimeTx = contract.transactionHash;
      } else {
        testDateTimeAddress = contract.address;
        addAccount(testDateTimeAddress, "TestDateTime");
        console.log("DATA: testDateTimeAddress=" + testDateTimeAddress);
      }
    }
  }
);
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(testDateTimeTx, testDateTimeMessage);
printTxData("testDateTimeAddress=" + testDateTimeAddress, testDateTimeTx);
console.log("RESULT: ");


console.log("RESULT: ---------- Test toTimestamp(...) against JavaScript Date with first day = 0 or 1 ----------");
for (var year = 2014; year < 2025; year++) {
  for (var month = 1; month <= 12; month++) {
    var toTimestamp = testDateTime.toTimestampYYYYMM(year, month);
    var toTimestamp1 = testDateTime.toTimestampYYYYMMDD(year, month, 0);
    var jsDate = new Date(toTimestamp * 1000);
    var jsDate1 = new Date(toTimestamp1 * 1000);
    console.log("RESULT: toTimestampYYYYMM(" + year + ", " + month + ") = " + toTimestamp + " " + jsDate.toUTCString());
    console.log("RESULT: toTimestampYYYYMMDD(" + year + ", " + month + ", 1) = " + toTimestamp1 + " " + jsDate1.toUTCString());
    if (year == jsDate.getUTCFullYear() && month == (parseInt(jsDate.getUTCMonth()) + 1) &&
      year == jsDate1.getUTCFullYear() && month == (parseInt(jsDate1.getUTCMonth()) + 1)) {
      console.log("RESULT: PASS");
    } else {
      console.log("RESULT: FAIL");
    }
  }
}


console.log("RESULT: ---------- Test fromTimestamp(...) and toTimestamp(...) against JavaScript Date ----------");
var now = new Date()/1000;
for (var i = parseInt(now) - 500000000; i < parseInt(now) + 500000000; i = parseInt(i) + 1000000 + new Date() % 173) {
  var fromTimestamp = testDateTime.fromTimestamp(i);
  var toTimestamp = testDateTime.toTimestamp(fromTimestamp[0], fromTimestamp[1], fromTimestamp[2], fromTimestamp[3], fromTimestamp[4], fromTimestamp[5]);
  var jsDate = new Date(i * 1000);
  if (jsDate.getUTCFullYear() == fromTimestamp[0] && parseInt(jsDate.getUTCMonth() + 1) == fromTimestamp[1] && jsDate.getUTCDate() == fromTimestamp[2] &&
    jsDate.getUTCHours() == fromTimestamp[3] && jsDate.getUTCMinutes() == fromTimestamp[4] && jsDate.getUTCSeconds() == fromTimestamp[5]) {
    console.log("RESULT: PASS jsDate matches");
  } else {
    console.log("RESULT: FAIL? jsDate.getUTCFullYear()=" + jsDate.getUTCFullYear() + " fromTimestamp[0]=" + fromTimestamp[0]);
    console.log("RESULT: FAIL? jsDate.getUTCMonth()+1=" + (parseInt(jsDate.getUTCMonth()) + 1) + " fromTimestamp[1]=" + fromTimestamp[1]);
    console.log("RESULT: FAIL? jsDate.getUTCDate()=" + jsDate.getUTCDate() + " fromTimestamp[2]=" + fromTimestamp[2]);
    console.log("RESULT: FAIL? jsDate.getUTCHours()=" + jsDate.getUTCHours() + " fromTimestamp[3]=" + fromTimestamp[3]);
    console.log("RESULT: FAIL? jsDate.getUTCMinutes()=" + jsDate.getUTCMinutes() + " fromTimestamp[4]=" + fromTimestamp[4]);
    console.log("RESULT: FAIL? jsDate.getUTCSeconds()=" + jsDate.getUTCSeconds() + " fromTimestamp[5]=" + fromTimestamp[5]);
  }
  console.log("RESULT: now=" + i + " fromTimestamp=" + JSON.stringify(fromTimestamp));
  if (i == toTimestamp) {
    console.log("RESULT: PASS now=" + i + " fromTimestamp=" + JSON.stringify(fromTimestamp) + " toTimestamp=" + toTimestamp);
  } else {
    console.log("RESULT: FAIL now=" + i + " fromTimestamp=" + JSON.stringify(fromTimestamp)+ " toTimestamp=" + toTimestamp);
  }
}


EOF
grep "DATA: " $TEST2OUTPUT | sed "s/DATA: //" > $DEPLOYMENTDATA
cat $DEPLOYMENTDATA
grep "RESULT: " $TEST2OUTPUT | sed "s/RESULT: //" > $TEST2RESULTS
cat $TEST2RESULTS
