# Orbs Subscription, Billing And Token Contract Audit

## Summary

[Orbs](https://www.orbs.com/) intends to run a subscription and billing service using Ethereum smart contracts.

Bok Consulting Pty Ltd was commissioned to perform an audit Orbs' token, subscription and billing Ethereum smart contracts.

This audit has been conducted on Orbs' [subscription and billing source code](https://github.com/orbs-network/orbs-subscription) in commits
[6c9e39d](https://github.com/orbs-network/orbs-subscription/commit/6c9e39ddbc4c0405eb6f0c7c66bef0baaf66acd9),
[a380e8e](https://github.com/orbs-network/orbs-subscription/commit/a380e8e61d4a332da99d8aa3dc3bec0293651f9d) and
[9d9b178](https://github.com/orbs-network/orbs-subscription/commit/9d9b1788daf221082854b16a9d570c8743ea2a77).

This audit has also been conducted on Orbs' [token source code](https://github.com/orbs-network/orbs-token) in commits
[044e1e4](https://github.com/orbs-network/orbs-token/commit/044e1e49bab83604cbc3c2522036cd0163dc93cf).

No potential vulnerabilities have been identified in the token, subscription and billing contracts.

<br />

<hr />

## Table Of Contents

* [Summary](#summary)
* [Recommendations](#recommendations)
* [Notes](#notes)
* [Potential Vulnerabilities](#potential-vulnerabilities)
* [Scope](#scope)
* [Limitations](#limitations)
* [Risks](#risks)
* [Testing](#testing)
* [Code Review](#code-review)

<br />

<hr />

## Recommendations

None

<br />

<hr />

## Notes

* Note that the `minimalMonthlySubscription` check in `Subscription.subscribe(...)` will only check that the first `subscribe(...)` transaction exceeds this threshold. Subsequent `subscribe(...)` transactions will always pass this check, regardless of the amount of tokens sent
* The *DateTime* library uses 1 to represent January, up to 12 to represent December
* The *DateTime* library uses 1 to represent the first day of the month, up to 31 to represent the last day of the month. The `toTimestamp(uint16 _year, uint8 _month, uint8 _day, uint8 _hour, uint8 _minutes, uint8 _seconds)` function will also accept 0 as the first day of the month
* In `DateTime.toTimestamp(uint16 _year, uint8 _month)`, the third function parameter in the call to `return toTimestamp(_year, _month, 0, 0, 0, 0);` can be specified as 0 to represent the first day of the month

<br />

<hr />

## Potential Vulnerabilities

No potential vulnerabilities have been identified in the token, subscription and billing contracts.

<br />

<hr />

## Scope

This audit is into the technical aspects of the token, subscription and billing contracts. The primary aim of this audit is to ensure that tokens
used with these contracts are not easily attacked or stolen by third parties. The secondary aim of this audit is to ensure the coded algorithms work as expected. This audit does not guarantee that that the code is bugfree, but intends to highlight any areas of weaknesses.

<br />

<hr />

## Limitations

This audit makes no statements or warranties about the viability of the Orbs' business proposition, the individuals involved in this business or the regulatory regime for the business model.

<br />

<hr />

## Risks

None identified.

<br />

<hr />

## Testing

Details of the testing environment can be found in [test](test).

### Subscription And Billing

The following functions were tested using the script [test/01_test1.sh](test/01_test1.sh) with the summary results saved
in [test/test1results.txt](test/test1results.txt) and the detailed output saved in [test/test1output.txt](test/test1output.txt):

* [x] Deploy DateTime library
* [x] Deploy token contract
* [x] Deploy SubscriptionBilling contract
* [x] Each FederationMember `approve(...)`s for their tokens to be transferred to the SubscriptionBilling contract
* [x] Each FederationMember executes `SubscriptionBilling.subscribeForCurrentMonth(...)`
* [x] Execute `SubscriptionBilling.distributeFees(...)` to distribute fee tokens to each FederationMember

<br />

### DateTime

The following functions were tested using the script [test/02_testDateTime.sh](test/02_testDateTime.sh) with the summary results saved
in [test/test2results.txt](test/test2results.txt) and the detailed output saved in [test/test2output.txt](test/test2output.txt):

* [x] Deploy DateTime library
* [x] Deploy TestDateTime contract
* [x] For a range of Unix timestamps
  * [x] Generate the year/month/day hour/minute/second from the Unix timestamp
  * [x] Generate the Unix timestamp from the calculated year/month/day hour/minute/second
  * [x] Compare the year/month/day hour/minute/second to the JavaScript **Date** calculation

<br />

<hr />

## Code Review

### From OrbsSubscription
* [x] [code-review/DateTime.md](code-review/DateTime.md)
  * [x] library DateTime
    * [x] using SafeMath for uint256;
    * [x] using SafeMath for uint16;
    * [x] using SafeMath for uint8;
* [x] [code-review/SubscriptionBilling.md](code-review/SubscriptionBilling.md)
  * [x] contract SubscriptionBilling is HasNoContracts
    * [x] using SafeMath for uint256;

### OrbsToken

From [orbs-token](https://github.com/orbs-network/orbs-token/commit/044e1e49bab83604cbc3c2522036cd0163dc93cf):

* [x] [orbstoken-code-review/OrbsToken.md](orbstoken-code-review/OrbsToken.md)
  * [x] contract OrbsToken is HasNoTokens, HasNoContracts, StandardToken

<br />

### OpenZeppelin 1.9.0 Dependencies

From [openzeppelin-solidity](https://github.com/OpenZeppelin/openzeppelin-solidity/tree/v1.9.0/contracts):

* [x] [openzeppelin-code-review/math/SafeMath.md](openzeppelin-code-review/math/SafeMath.md)
  * [x] library SafeMath
* [x] [openzeppelin-code-review/ownership/Ownable.md](openzeppelin-code-review/ownership/Ownable.md)
  * [x] contract Ownable
* [x] [openzeppelin-code-review/ownership/HasNoContracts.md](openzeppelin-code-review/ownership/HasNoContracts.md)
  * [x] contract HasNoContracts is Ownable
* [x] [openzeppelin-code-review/ownership/CanReclaimToken.md](openzeppelin-code-review/ownership/CanReclaimToken.md)
  * [x] contract CanReclaimToken is Ownable
    * [x] using SafeERC20 for ERC20Basic;
* [x] [openzeppelin-code-review/ownership/HasNoTokens.md](openzeppelin-code-review/ownership/HasNoTokens.md)
  * [x] contract HasNoTokens is CanReclaimToken
* [x] [openzeppelin-code-review/token/ERC20/ERC20Basic.md](openzeppelin-code-review/token/ERC20/ERC20Basic.md)
  * [x] contract ERC20Basic
* [x] [openzeppelin-code-review/token/ERC20/ERC20.md](openzeppelin-code-review/token/ERC20/ERC20.md)
  * [x] contract ERC20 is ERC20Basic
* [x] [openzeppelin-code-review/token/ERC20/BasicToken.md](openzeppelin-code-review/token/ERC20/BasicToken.md)
  * [x] contract BasicToken is ERC20Basic
    * [x] using SafeMath for uint256;
* [x] [openzeppelin-code-review/token/ERC20/StandardToken.md](openzeppelin-code-review/token/ERC20/StandardToken.md)
  * [x] contract StandardToken is ERC20, BasicToken
* [x] [openzeppelin-code-review/token/ERC20/SafeERC20.md](openzeppelin-code-review/token/ERC20/SafeERC20.md)
  * [x] library SafeERC20

<br />

### Excluded - Only Used For Testing

* [../contracts/Migrations.sol](../contracts/Migrations.sol)

<br />

### Solidity Compiler Error

There is a Solidity command line compiler bug in OS/X version 0.4.23 where certain statements in the constructor cannot be evaluated without the compiler throwing an internal error. The statement that triggers this error is in the constructor of *OrbsToken.sol* and are the lines `totalSupply_ = totalSupply_.add(TOTAL_SUPPLY);` and `balances[_distributor] = balances[_distributor].add(TOTAL_SUPPLY);`. For this testing, these statement have been replaced with `totalSupply_ = TOTAL_SUPPLY;` and `balances[_distributor] = TOTAL_SUPPLY;` to enable the compilation of the Solidity smart contracts.

This error does not appear in the Remix version of Solidity compiler 0.4.23.

```
solc, the solidity compiler commandline interface
Version: 0.4.23+commit.124ca40d.Darwin.appleclang
Internal compiler error during compilation:
/tmp/solidity-20180501-9472-436klv/solidity_0.4.23/libsolidity/interface/CompilerStack.cpp(732): Throw in function void dev::solidity::CompilerStack::compileContract(const dev::solidity::ContractDefinition &, map<const dev::solidity::ContractDefinition *, const eth::Assembly *> &)
Dynamic exception type: boost::exception_detail::clone_impl<dev::solidity::InternalCompilerError>
std::exception::what: Assembly exception for bytecode
[dev::tag_comment*] = Assembly exception for bytecode
```

The differences in *OrbsToken.sol* to enable the Solidity compilation are:

```
--- Differences ../orbstoken-contracts/OrbsToken.sol OrbsToken.sol ---
20,21c20,21
<         totalSupply_ = totalSupply_.add(TOTAL_SUPPLY);
<         balances[_distributor] = balances[_distributor].add(TOTAL_SUPPLY);
---
>         totalSupply_ = TOTAL_SUPPLY;
>         balances[_distributor] = TOTAL_SUPPLY;
```

<br />

<br />

(c) BokkyPooBah / Bok Consulting Pty Ltd for Orbs - May 30 2018. The MIT Licence.