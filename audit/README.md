

https://github.com/orbs-network/orbs-token/commit/044e1e49bab83604cbc3c2522036cd0163dc93cf

https://github.com/orbs-network/orbs-subscription/commit/6c9e39ddbc4c0405eb6f0c7c66bef0baaf66acd9


## Table Of Contents

<br />

<hr />

## Code Review

* [ ] [code-review/DateTime.md](code-review/DateTime.md)
  * [ ] library DateTime
  * [ ]     using SafeMath for uint256;
  * [ ]     using SafeMath for uint16;
  * [ ]     using SafeMath for uint8;
* [ ] [code-review/Migrations.md](code-review/Migrations.md)
  * [ ] contract Migrations
* [ ] [code-review/SubscriptionBilling.md](code-review/SubscriptionBilling.md)
  * [ ] contract SubscriptionBilling is HasNoContracts
  * [ ]     using SafeMath for uint256;



* [ ] [code-review/OrbsToken.md](code-review/OrbsToken.md)
  * [ ] contract OrbsToken is HasNoTokens, HasNoContracts, StandardToken


* [ ] [code-review/SafeMath.md](code-review/SafeMath.md)
  * [ ] library SafeMath


* [ ] [code-review/CanReclaimToken.md](code-review/CanReclaimToken.md)
  * [ ] contract CanReclaimToken is Ownable
  * [ ]   using SafeERC20 for ERC20Basic;
* [ ] [code-review/HasNoContracts.md](code-review/HasNoContracts.md)
  * [ ] contract HasNoContracts is Ownable
* [ ] [code-review/HasNoTokens.md](code-review/HasNoTokens.md)
  * [ ] contract HasNoTokens is CanReclaimToken
* [ ] [code-review/Ownable.md](code-review/Ownable.md)
  * [ ] contract Ownable


* [ ] [code-review/BasicToken.md](code-review/BasicToken.md)
  * [ ] contract BasicToken is ERC20Basic
  * [ ]   using SafeMath for uint256;
* [ ] [code-review/ERC20.md](code-review/ERC20.md)
  * [ ] contract ERC20 is ERC20Basic
* [ ] [code-review/ERC20Basic.md](code-review/ERC20Basic.md)
  * [ ] contract ERC20Basic
* [ ] [code-review/SafeERC20.md](code-review/SafeERC20.md)
  * [ ] library SafeERC20
* [ ] [code-review/StandardToken.md](code-review/StandardToken.md)
  * [ ] contract StandardToken is ERC20, BasicToken

<br />

### Solidity Compiler Error

In OrbsToken.sol, statement `totalSupply_ = totalSupply_.add(TOTAL_SUPPLY);` and `balances[_distributor] = balances[_distributor].add(TOTAL_SUPPLY);`:

```
solc, the solidity compiler commandline interface
Version: 0.4.23+commit.124ca40d.Darwin.appleclang
Internal compiler error during compilation:
/tmp/solidity-20180501-9472-436klv/solidity_0.4.23/libsolidity/interface/CompilerStack.cpp(732): Throw in function void dev::solidity::CompilerStack::compileContract(const dev::solidity::ContractDefinition &, map<const dev::solidity::ContractDefinition *, const eth::Assembly *> &)
Dynamic exception type: boost::exception_detail::clone_impl<dev::solidity::InternalCompilerError>
std::exception::what: Assembly exception for bytecode
[dev::tag_comment*] = Assembly exception for bytecode
```

For this testing, the following changes were made to OrbsToken.sol to enable the Solidity compilation:

```
--- Differences ../orbstoken-contracts/OrbsToken.sol OrbsToken.sol ---
20,21c20,21
<         totalSupply_ = totalSupply_.add(TOTAL_SUPPLY);
<         balances[_distributor] = balances[_distributor].add(TOTAL_SUPPLY);
---
>         totalSupply_ = TOTAL_SUPPLY;
>         balances[_distributor] = TOTAL_SUPPLY;
```