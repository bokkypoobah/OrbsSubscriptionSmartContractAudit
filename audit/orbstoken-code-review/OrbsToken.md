# OrbsToken

Source file [../orbstoken-contracts/OrbsToken.sol](../orbstoken-contracts/OrbsToken.sol).

<br />

<hr />

```javascript
// BK Ok
pragma solidity 0.4.23;

// BK Ok
import "zeppelin-solidity/contracts/ownership/HasNoContracts.sol";
import "zeppelin-solidity/contracts/ownership/HasNoTokens.sol";
import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";

// BK Ok
contract OrbsToken is HasNoTokens, HasNoContracts, StandardToken {
    // solhint-disable const-name-snakecase
    // BK Next 3 Ok
    string public constant name = "Orbs";
    string public constant symbol = "ORBS";
    uint8 public constant decimals = 18;
    // solhint-enable const-name-snakecase

    // Total supply of the ORBS token.
    // BK Ok
    uint256 public constant TOTAL_SUPPLY = 10 * 10 ** 9 * 10 ** uint256(decimals); // 10B

    // BK Ok
    constructor(address _distributor) public {
        // BK Ok
        require(_distributor != address(0), "Distributor address must not be 0!");

        // BK Ok
        totalSupply_ = totalSupply_.add(TOTAL_SUPPLY);
        // BK Ok
        balances[_distributor] = balances[_distributor].add(TOTAL_SUPPLY);
        // BK Ok - Log event
        emit Transfer(address(0), _distributor, TOTAL_SUPPLY);
    }
}

```
