# BasicToken

Source file [../../../openzeppelin-contracts/token/ERC20/BasicToken.sol](../../../openzeppelin-contracts/token/ERC20/BasicToken.sol).

<br />

<hr />

```javascript
// BK Ok
pragma solidity ^0.4.21;


// BK Next 2 Ok
import "./ERC20Basic.sol";
import "../../math/SafeMath.sol";


/**
 * @title Basic token
 * @dev Basic version of StandardToken, with no allowances.
 */
// BK Ok
contract BasicToken is ERC20Basic {
  // BK Ok
  using SafeMath for uint256;

  // BK Ok
  mapping(address => uint256) balances;

  // BK Ok
  uint256 totalSupply_;

  /**
  * @dev total number of tokens in existence
  */
  // BK Ok - View function
  function totalSupply() public view returns (uint256) {
    // BK Ok
    return totalSupply_;
  }

  /**
  * @dev transfer token for a specified address
  * @param _to The address to transfer to.
  * @param _value The amount to be transferred.
  */
  // BK Ok - Any account can execute this function
  function transfer(address _to, uint256 _value) public returns (bool) {
    // BK Ok - Cannot burn to 0x0
    require(_to != address(0));
    // BK Ok - Must have sufficient balance
    require(_value <= balances[msg.sender]);

    // BK Ok
    balances[msg.sender] = balances[msg.sender].sub(_value);
    // BK Ok
    balances[_to] = balances[_to].add(_value);
    // BK Ok - Log event
    emit Transfer(msg.sender, _to, _value);
    // BK Ok
    return true;
  }

  /**
  * @dev Gets the balance of the specified address.
  * @param _owner The address to query the the balance of.
  * @return An uint256 representing the amount owned by the passed address.
  */
  // BK Ok - View function
  function balanceOf(address _owner) public view returns (uint256) {
    // BK Ok
    return balances[_owner];
  }

}

```
