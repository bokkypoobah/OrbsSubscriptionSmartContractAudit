# HasNoContracts

Source file [../../openzeppelin-contracts/ownership/HasNoContracts.sol](../../openzeppelin-contracts/ownership/HasNoContracts.sol).

<br />

<hr />

```javascript
// BK Ok
pragma solidity ^0.4.21;

// BK Ok
import "./Ownable.sol";


/**
 * @title Contracts that should not own Contracts
 * @author Remco Bloemen <remco@2π.com>
 * @dev Should contracts (anything Ownable) end up being owned by this contract, it allows the owner
 * of this contract to reclaim ownership of the contracts.
 */
// BK Ok
contract HasNoContracts is Ownable {

  /**
   * @dev Reclaim ownership of Ownable contracts
   * @param contractAddr The address of the Ownable to be reclaimed.
   */
  // BK Ok - Only owner can execute
  function reclaimContract(address contractAddr) external onlyOwner {
    // BK Ok
    Ownable contractInst = Ownable(contractAddr);
    // BK Ok
    contractInst.transferOwnership(owner);
  }
}

```
