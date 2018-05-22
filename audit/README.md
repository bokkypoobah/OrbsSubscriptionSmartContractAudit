

https://github.com/orbs-network/orbs-token/commit/044e1e49bab83604cbc3c2522036cd0163dc93cf

https://github.com/orbs-network/orbs-subscription/commit/6c9e39ddbc4c0405eb6f0c7c66bef0baaf66acd9


## Table Of Contents

<br />

<hr />

## Testing

Details of the testing environment can be found in [test](test).

The following functions were tested using the script [test/01_test1.sh](test/01_test1.sh) with the summary results saved
in [test/test1results.txt](test/test1results.txt) and the detailed output saved in [test/test1output.txt](test/test1output.txt):

* [x] Deploy members library
* [x] Deploy token contract
* [x] Deploy SubscriptionBilling contract

<br />

<hr />

## Code Review

### From OrbsSubscription
* [ ] [code-review/DateTime.md](code-review/DateTime.md)
  * [ ] library DateTime
    * [ ] using SafeMath for uint256;
    * [ ] using SafeMath for uint16;
    * [ ] using SafeMath for uint8;
* [ ] [code-review/SubscriptionBilling.md](code-review/SubscriptionBilling.md)
  * [ ] contract SubscriptionBilling is HasNoContracts
    * [ ] using SafeMath for uint256;

### From OrbsToken
* [ ] [code-review/OrbsToken.md](code-review/OrbsToken.md)
  * [ ] contract OrbsToken is HasNoTokens, HasNoContracts, StandardToken

<br />

### OpenZeppelin 1.8.0 Dependencies
* [ ] [openzeppelin-code-review/math/SafeMath.md](openzeppelin-code-review/math/SafeMath.md)
  * [ ] library SafeMath
* [ ] [openzeppelin-code-review/ownership/CanReclaimToken.md](openzeppelin-code-review/ownership/CanReclaimToken.md)
  * [ ] contract CanReclaimToken is Ownable
    * [ ] using SafeERC20 for ERC20Basic;
* [ ] [openzeppelin-code-review/ownership/HasNoContracts.md](openzeppelin-code-review/ownership/HasNoContracts.md)
  * [ ] contract HasNoContracts is Ownable
* [ ] [openzeppelin-code-review/ownership/HasNoTokens.md](openzeppelin-code-review/ownership/HasNoTokens.md)
  * [ ] contract HasNoTokens is CanReclaimToken
* [ ] [openzeppelin-code-review/ownership/Ownable.md](openzeppelin-code-review/ownership/Ownable.md)
  * [ ] contract Ownable
* [ ] [openzeppelin-code-review/token/ERC20/BasicToken.md](openzeppelin-code-review/token/ERC20/BasicToken.md)
  * [ ] contract BasicToken is ERC20Basic
    * [ ] using SafeMath for uint256;
* [ ] [openzeppelin-code-review/token/ERC20/ERC20.md](openzeppelin-code-review/token/ERC20/ERC20.md)
  * [ ] contract ERC20 is ERC20Basic
* [ ] [openzeppelin-code-review/token/ERC20/ERC20Basic.md](openzeppelin-code-review/token/ERC20/ERC20Basic.md)
  * [ ] contract ERC20Basic
* [ ] [openzeppelin-code-review/token/ERC20/SafeERC20.md](openzeppelin-code-review/token/ERC20/SafeERC20.md)
  * [ ] library SafeERC20
* [ ] [openzeppelin-code-review/token/ERC20/StandardToken.md](openzeppelin-code-review/token/ERC20/StandardToken.md)
  * [ ] contract StandardToken is ERC20, BasicToken

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