var tokenOutput={
  "contracts" : 
  {
    "OrbsToken.sol:OrbsToken" : 
    {
      "abi" : "[{\"constant\":true,\"inputs\":[],\"name\":\"name\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_spender\",\"type\":\"address\"},{\"name\":\"_value\",\"type\":\"uint256\"}],\"name\":\"approve\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"token\",\"type\":\"address\"}],\"name\":\"reclaimToken\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"totalSupply\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_from\",\"type\":\"address\"},{\"name\":\"_to\",\"type\":\"address\"},{\"name\":\"_value\",\"type\":\"uint256\"}],\"name\":\"transferFrom\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"contractAddr\",\"type\":\"address\"}],\"name\":\"reclaimContract\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"decimals\",\"outputs\":[{\"name\":\"\",\"type\":\"uint8\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_spender\",\"type\":\"address\"},{\"name\":\"_subtractedValue\",\"type\":\"uint256\"}],\"name\":\"decreaseApproval\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_owner\",\"type\":\"address\"}],\"name\":\"balanceOf\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"owner\",\"outputs\":[{\"name\":\"\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"TOTAL_SUPPLY\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"symbol\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_to\",\"type\":\"address\"},{\"name\":\"_value\",\"type\":\"uint256\"}],\"name\":\"transfer\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"from_\",\"type\":\"address\"},{\"name\":\"value_\",\"type\":\"uint256\"},{\"name\":\"data_\",\"type\":\"bytes\"}],\"name\":\"tokenFallback\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_spender\",\"type\":\"address\"},{\"name\":\"_addedValue\",\"type\":\"uint256\"}],\"name\":\"increaseApproval\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_owner\",\"type\":\"address\"},{\"name\":\"_spender\",\"type\":\"address\"}],\"name\":\"allowance\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"newOwner\",\"type\":\"address\"}],\"name\":\"transferOwnership\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"name\":\"_distributor\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"owner\",\"type\":\"address\"},{\"indexed\":true,\"name\":\"spender\",\"type\":\"address\"},{\"indexed\":false,\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"Approval\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"from\",\"type\":\"address\"},{\"indexed\":true,\"name\":\"to\",\"type\":\"address\"},{\"indexed\":false,\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"Transfer\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"previousOwner\",\"type\":\"address\"},{\"indexed\":true,\"name\":\"newOwner\",\"type\":\"address\"}],\"name\":\"OwnershipTransferred\",\"type\":\"event\"}]",
      "bin" : "608060405234801561001057600080fd5b50604051602080610d58833981016040525160008054600160a060020a03191633600160a060020a0390811691909117909155811615156100d857604080517f08c379a000000000000000000000000000000000000000000000000000000000815260206004820152602260248201527f4469737472696275746f722061646472657373206d757374206e6f742062652060448201527f3021000000000000000000000000000000000000000000000000000000000000606482015290519081900360840190fd5b6b204fce5e3e250261100000006002819055600160a060020a0382166000818152600160209081526040808320859055805194855251929391927fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef9281900390910190a350610c0c8061014c6000396000f3006080604052600436106100d75763ffffffff60e060020a60003504166306fdde0381146100dc578063095ea7b31461016657806317ffc3201461019e57806318160ddd146101c157806323b872dd146101e85780632aed7f3f14610212578063313ce56714610233578063661884631461025e57806370a08231146102825780638da5cb5b146102a3578063902d55a5146102d457806395d89b41146102e9578063a9059cbb146102fe578063c0ee0b8a14610322578063d73dd62314610353578063dd62ed3e14610377578063f2fde38b1461039e575b600080fd5b3480156100e857600080fd5b506100f16103bf565b6040805160208082528351818301528351919283929083019185019080838360005b8381101561012b578181015183820152602001610113565b50505050905090810190601f1680156101585780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b34801561017257600080fd5b5061018a600160a060020a03600435166024356103f6565b604080519115158252519081900360200190f35b3480156101aa57600080fd5b506101bf600160a060020a0360043516610460565b005b3480156101cd57600080fd5b506101d661052a565b60408051918252519081900360200190f35b3480156101f457600080fd5b5061018a600160a060020a0360043581169060243516604435610530565b34801561021e57600080fd5b506101bf600160a060020a03600435166106b2565b34801561023f57600080fd5b50610248610750565b6040805160ff9092168252519081900360200190f35b34801561026a57600080fd5b5061018a600160a060020a0360043516602435610755565b34801561028e57600080fd5b506101d6600160a060020a036004351661084e565b3480156102af57600080fd5b506102b8610869565b60408051600160a060020a039092168252519081900360200190f35b3480156102e057600080fd5b506101d6610878565b3480156102f557600080fd5b506100f1610888565b34801561030a57600080fd5b5061018a600160a060020a03600435166024356108bf565b34801561032e57600080fd5b506101bf60048035600160a060020a03169060248035916044359182019101356100d7565b34801561035f57600080fd5b5061018a600160a060020a03600435166024356109ba565b34801561038357600080fd5b506101d6600160a060020a0360043581169060243516610a5c565b3480156103aa57600080fd5b506101bf600160a060020a0360043516610a87565b60408051808201909152600481527f4f72627300000000000000000000000000000000000000000000000000000000602082015281565b600160a060020a03338116600081815260036020908152604080832094871680845294825280832086905580518681529051929493927f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925929181900390910190a350600192915050565b6000805433600160a060020a0390811691161461047c57600080fd5b81600160a060020a03166370a08231306040518263ffffffff1660e060020a0281526004018082600160a060020a0316600160a060020a03168152602001915050602060405180830381600087803b1580156104d757600080fd5b505af11580156104eb573d6000803e3d6000fd5b505050506040513d602081101561050157600080fd5b505160005490915061052690600160a060020a0384811691168363ffffffff610b1f16565b5050565b60025490565b6000600160a060020a038316151561054757600080fd5b600160a060020a03841660009081526001602052604090205482111561056c57600080fd5b600160a060020a038085166000908152600360209081526040808320339094168352929052205482111561059f57600080fd5b600160a060020a0384166000908152600160205260409020546105c8908363ffffffff610bbb16565b600160a060020a0380861660009081526001602052604080822093909355908516815220546105fd908363ffffffff610bcd16565b600160a060020a03808516600090815260016020908152604080832094909455878316825260038152838220339093168252919091522054610645908363ffffffff610bbb16565b600160a060020a038086166000818152600360209081526040808320338616845282529182902094909455805186815290519287169391927fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef929181900390910190a35060019392505050565b6000805433600160a060020a039081169116146106ce57600080fd5b5060008054604080517ff2fde38b000000000000000000000000000000000000000000000000000000008152600160a060020a039283166004820152905184939284169263f2fde38b926024808201939182900301818387803b15801561073457600080fd5b505af1158015610748573d6000803e3d6000fd5b505050505050565b601281565b600160a060020a033381166000908152600360209081526040808320938616835292905290812054808311156107b257600160a060020a0333811660009081526003602090815260408083209388168352929052908120556107e9565b6107c2818463ffffffff610bbb16565b600160a060020a033381166000908152600360209081526040808320938916835292905220555b600160a060020a0333811660008181526003602090815260408083209489168084529482529182902054825190815291517f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b9259281900390910190a35060019392505050565b600160a060020a031660009081526001602052604090205490565b600054600160a060020a031681565b6b204fce5e3e2502611000000081565b60408051808201909152600481527f4f52425300000000000000000000000000000000000000000000000000000000602082015281565b6000600160a060020a03831615156108d657600080fd5b600160a060020a0333166000908152600160205260409020548211156108fb57600080fd5b600160a060020a033316600090815260016020526040902054610924908363ffffffff610bbb16565b600160a060020a033381166000908152600160205260408082209390935590851681522054610959908363ffffffff610bcd16565b600160a060020a038085166000818152600160209081526040918290209490945580518681529051919333909316927fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef92918290030190a350600192915050565b600160a060020a0333811660009081526003602090815260408083209386168352929052908120546109f2908363ffffffff610bcd16565b600160a060020a0333811660008181526003602090815260408083209489168084529482529182902085905581519485529051929391927f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b9259281900390910190a350600192915050565b600160a060020a03918216600090815260036020908152604080832093909416825291909152205490565b60005433600160a060020a03908116911614610aa257600080fd5b600160a060020a0381161515610ab757600080fd5b60008054604051600160a060020a03808516939216917f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e091a36000805473ffffffffffffffffffffffffffffffffffffffff1916600160a060020a0392909216919091179055565b82600160a060020a031663a9059cbb83836040518363ffffffff1660e060020a0281526004018083600160a060020a0316600160a060020a0316815260200182815260200192505050602060405180830381600087803b158015610b8257600080fd5b505af1158015610b96573d6000803e3d6000fd5b505050506040513d6020811015610bac57600080fd5b50511515610bb657fe5b505050565b600082821115610bc757fe5b50900390565b81810182811015610bda57fe5b929150505600a165627a7a72305820b34fede552619dfa3b3e6e9fab2227f2730adb81e606a4efb3472bdc4b275f0c0029"
    },
    "math/SafeMath.sol:SafeMath" : 
    {
      "abi" : "[]",
      "bin" : "604c602c600b82828239805160001a60731460008114601c57601e565bfe5b5030600052607381538281f30073000000000000000000000000000000000000000030146080604052600080fd00a165627a7a7230582013294036924631d150abff0db23f59de01c864f35341d5935b8d2eb7d57d6bae0029"
    },
    "ownership/CanReclaimToken.sol:CanReclaimToken" : 
    {
      "abi" : "[{\"constant\":false,\"inputs\":[{\"name\":\"token\",\"type\":\"address\"}],\"name\":\"reclaimToken\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"owner\",\"outputs\":[{\"name\":\"\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"newOwner\",\"type\":\"address\"}],\"name\":\"transferOwnership\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"previousOwner\",\"type\":\"address\"},{\"indexed\":true,\"name\":\"newOwner\",\"type\":\"address\"}],\"name\":\"OwnershipTransferred\",\"type\":\"event\"}]",
      "bin" : "608060405260008054600160a060020a033316600160a060020a03199091161790556102f0806100306000396000f30060806040526004361061003d5763ffffffff60e060020a60003504166317ffc32081146100425780638da5cb5b14610065578063f2fde38b14610096575b600080fd5b34801561004e57600080fd5b50610063600160a060020a03600435166100b7565b005b34801561007157600080fd5b5061007a610181565b60408051600160a060020a039092168252519081900360200190f35b3480156100a257600080fd5b50610063600160a060020a0360043516610190565b6000805433600160a060020a039081169116146100d357600080fd5b81600160a060020a03166370a08231306040518263ffffffff1660e060020a0281526004018082600160a060020a0316600160a060020a03168152602001915050602060405180830381600087803b15801561012e57600080fd5b505af1158015610142573d6000803e3d6000fd5b505050506040513d602081101561015857600080fd5b505160005490915061017d90600160a060020a0384811691168363ffffffff61022816565b5050565b600054600160a060020a031681565b60005433600160a060020a039081169116146101ab57600080fd5b600160a060020a03811615156101c057600080fd5b60008054604051600160a060020a03808516939216917f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e091a36000805473ffffffffffffffffffffffffffffffffffffffff1916600160a060020a0392909216919091179055565b82600160a060020a031663a9059cbb83836040518363ffffffff1660e060020a0281526004018083600160a060020a0316600160a060020a0316815260200182815260200192505050602060405180830381600087803b15801561028b57600080fd5b505af115801561029f573d6000803e3d6000fd5b505050506040513d60208110156102b557600080fd5b505115156102bf57fe5b5050505600a165627a7a72305820bdb5e874a659d68688c36f71ab669973a39a9fa4402be0f799784fcd61eca4480029"
    },
    "ownership/HasNoContracts.sol:HasNoContracts" : 
    {
      "abi" : "[{\"constant\":false,\"inputs\":[{\"name\":\"contractAddr\",\"type\":\"address\"}],\"name\":\"reclaimContract\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"owner\",\"outputs\":[{\"name\":\"\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"newOwner\",\"type\":\"address\"}],\"name\":\"transferOwnership\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"previousOwner\",\"type\":\"address\"},{\"indexed\":true,\"name\":\"newOwner\",\"type\":\"address\"}],\"name\":\"OwnershipTransferred\",\"type\":\"event\"}]",
      "bin" : "608060405260008054600160a060020a033316600160a060020a0319909116179055610241806100306000396000f3006080604052600436106100565763ffffffff7c01000000000000000000000000000000000000000000000000000000006000350416632aed7f3f811461005b5780638da5cb5b1461007e578063f2fde38b146100af575b600080fd5b34801561006757600080fd5b5061007c600160a060020a03600435166100d0565b005b34801561008a57600080fd5b5061009361016e565b60408051600160a060020a039092168252519081900360200190f35b3480156100bb57600080fd5b5061007c600160a060020a036004351661017d565b6000805433600160a060020a039081169116146100ec57600080fd5b5060008054604080517ff2fde38b000000000000000000000000000000000000000000000000000000008152600160a060020a039283166004820152905184939284169263f2fde38b926024808201939182900301818387803b15801561015257600080fd5b505af1158015610166573d6000803e3d6000fd5b505050505050565b600054600160a060020a031681565b60005433600160a060020a0390811691161461019857600080fd5b600160a060020a03811615156101ad57600080fd5b60008054604051600160a060020a03808516939216917f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e091a36000805473ffffffffffffffffffffffffffffffffffffffff1916600160a060020a03929092169190911790555600a165627a7a72305820d346c50141cdd036cb51860a8f0f08ad4630513d57d748aec377990cc091966b0029"
    },
    "ownership/HasNoTokens.sol:HasNoTokens" : 
    {
      "abi" : "[{\"constant\":false,\"inputs\":[{\"name\":\"token\",\"type\":\"address\"}],\"name\":\"reclaimToken\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"owner\",\"outputs\":[{\"name\":\"\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"from_\",\"type\":\"address\"},{\"name\":\"value_\",\"type\":\"uint256\"},{\"name\":\"data_\",\"type\":\"bytes\"}],\"name\":\"tokenFallback\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"newOwner\",\"type\":\"address\"}],\"name\":\"transferOwnership\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"previousOwner\",\"type\":\"address\"},{\"indexed\":true,\"name\":\"newOwner\",\"type\":\"address\"}],\"name\":\"OwnershipTransferred\",\"type\":\"event\"}]",
      "bin" : "608060405260008054600160a060020a033316600160a060020a031990911617905561032c806100306000396000f3006080604052600436106100485763ffffffff60e060020a60003504166317ffc320811461004d5780638da5cb5b14610070578063c0ee0b8a146100a1578063f2fde38b146100d2575b600080fd5b34801561005957600080fd5b5061006e600160a060020a03600435166100f3565b005b34801561007c57600080fd5b506100856101bd565b60408051600160a060020a039092168252519081900360200190f35b3480156100ad57600080fd5b5061006e60048035600160a060020a0316906024803591604435918201910135610048565b3480156100de57600080fd5b5061006e600160a060020a03600435166101cc565b6000805433600160a060020a0390811691161461010f57600080fd5b81600160a060020a03166370a08231306040518263ffffffff1660e060020a0281526004018082600160a060020a0316600160a060020a03168152602001915050602060405180830381600087803b15801561016a57600080fd5b505af115801561017e573d6000803e3d6000fd5b505050506040513d602081101561019457600080fd5b50516000549091506101b990600160a060020a0384811691168363ffffffff61026416565b5050565b600054600160a060020a031681565b60005433600160a060020a039081169116146101e757600080fd5b600160a060020a03811615156101fc57600080fd5b60008054604051600160a060020a03808516939216917f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e091a36000805473ffffffffffffffffffffffffffffffffffffffff1916600160a060020a0392909216919091179055565b82600160a060020a031663a9059cbb83836040518363ffffffff1660e060020a0281526004018083600160a060020a0316600160a060020a0316815260200182815260200192505050602060405180830381600087803b1580156102c757600080fd5b505af11580156102db573d6000803e3d6000fd5b505050506040513d60208110156102f157600080fd5b505115156102fb57fe5b5050505600a165627a7a72305820ef325da363e3f0de0b1a8336fad3c3509a64e120ef04322f412e30be5d8599180029"
    },
    "ownership/Ownable.sol:Ownable" : 
    {
      "abi" : "[{\"constant\":true,\"inputs\":[],\"name\":\"owner\",\"outputs\":[{\"name\":\"\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"newOwner\",\"type\":\"address\"}],\"name\":\"transferOwnership\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"previousOwner\",\"type\":\"address\"},{\"indexed\":true,\"name\":\"newOwner\",\"type\":\"address\"}],\"name\":\"OwnershipTransferred\",\"type\":\"event\"}]",
      "bin" : "608060405234801561001057600080fd5b5060008054600160a060020a033316600160a060020a03199091161790556101778061003d6000396000f30060806040526004361061004b5763ffffffff7c01000000000000000000000000000000000000000000000000000000006000350416638da5cb5b8114610050578063f2fde38b14610081575b600080fd5b34801561005c57600080fd5b506100656100a4565b60408051600160a060020a039092168252519081900360200190f35b34801561008d57600080fd5b506100a2600160a060020a03600435166100b3565b005b600054600160a060020a031681565b60005433600160a060020a039081169116146100ce57600080fd5b600160a060020a03811615156100e357600080fd5b60008054604051600160a060020a03808516939216917f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e091a36000805473ffffffffffffffffffffffffffffffffffffffff1916600160a060020a03929092169190911790555600a165627a7a723058205525cfb2fedd5355dcd5279d645f74857d678d67ad8a39360b25f8ebc13c1c0b0029"
    },
    "token/ERC20/BasicToken.sol:BasicToken" : 
    {
      "abi" : "[{\"constant\":true,\"inputs\":[],\"name\":\"totalSupply\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_owner\",\"type\":\"address\"}],\"name\":\"balanceOf\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_to\",\"type\":\"address\"},{\"name\":\"_value\",\"type\":\"uint256\"}],\"name\":\"transfer\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"from\",\"type\":\"address\"},{\"indexed\":true,\"name\":\"to\",\"type\":\"address\"},{\"indexed\":false,\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"Transfer\",\"type\":\"event\"}]",
      "bin" : "608060405234801561001057600080fd5b50610246806100206000396000f3006080604052600436106100565763ffffffff7c010000000000000000000000000000000000000000000000000000000060003504166318160ddd811461005b57806370a0823114610082578063a9059cbb146100a3575b600080fd5b34801561006757600080fd5b506100706100db565b60408051918252519081900360200190f35b34801561008e57600080fd5b50610070600160a060020a03600435166100e1565b3480156100af57600080fd5b506100c7600160a060020a03600435166024356100fc565b604080519115158252519081900360200190f35b60015490565b600160a060020a031660009081526020819052604090205490565b6000600160a060020a038316151561011357600080fd5b600160a060020a03331660009081526020819052604090205482111561013857600080fd5b600160a060020a033316600090815260208190526040902054610161908363ffffffff6101f516565b600160a060020a033381166000908152602081905260408082209390935590851681522054610196908363ffffffff61020716565b600160a060020a03808516600081815260208181526040918290209490945580518681529051919333909316927fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef92918290030190a350600192915050565b60008282111561020157fe5b50900390565b8181018281101561021457fe5b929150505600a165627a7a72305820827ff1cea1937b00afe53c82a2a1a930fd4a3d7cc237d92daa9dbf53e5eefcd70029"
    },
    "token/ERC20/ERC20.sol:ERC20" : 
    {
      "abi" : "[{\"constant\":false,\"inputs\":[{\"name\":\"spender\",\"type\":\"address\"},{\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"approve\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"totalSupply\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"from\",\"type\":\"address\"},{\"name\":\"to\",\"type\":\"address\"},{\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"transferFrom\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"who\",\"type\":\"address\"}],\"name\":\"balanceOf\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"to\",\"type\":\"address\"},{\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"transfer\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"owner\",\"type\":\"address\"},{\"name\":\"spender\",\"type\":\"address\"}],\"name\":\"allowance\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"owner\",\"type\":\"address\"},{\"indexed\":true,\"name\":\"spender\",\"type\":\"address\"},{\"indexed\":false,\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"Approval\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"from\",\"type\":\"address\"},{\"indexed\":true,\"name\":\"to\",\"type\":\"address\"},{\"indexed\":false,\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"Transfer\",\"type\":\"event\"}]",
      "bin" : ""
    },
    "token/ERC20/ERC20Basic.sol:ERC20Basic" : 
    {
      "abi" : "[{\"constant\":true,\"inputs\":[],\"name\":\"totalSupply\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"who\",\"type\":\"address\"}],\"name\":\"balanceOf\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"to\",\"type\":\"address\"},{\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"transfer\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"from\",\"type\":\"address\"},{\"indexed\":true,\"name\":\"to\",\"type\":\"address\"},{\"indexed\":false,\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"Transfer\",\"type\":\"event\"}]",
      "bin" : ""
    },
    "token/ERC20/SafeERC20.sol:SafeERC20" : 
    {
      "abi" : "[]",
      "bin" : "604c602c600b82828239805160001a60731460008114601c57601e565bfe5b5030600052607381538281f30073000000000000000000000000000000000000000030146080604052600080fd00a165627a7a7230582095fee3b7e52d876271cfce408af21fb1b9d713201d201f3cd16858974caa2d970029"
    },
    "token/ERC20/StandardToken.sol:StandardToken" : 
    {
      "abi" : "[{\"constant\":false,\"inputs\":[{\"name\":\"_spender\",\"type\":\"address\"},{\"name\":\"_value\",\"type\":\"uint256\"}],\"name\":\"approve\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"totalSupply\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_from\",\"type\":\"address\"},{\"name\":\"_to\",\"type\":\"address\"},{\"name\":\"_value\",\"type\":\"uint256\"}],\"name\":\"transferFrom\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_spender\",\"type\":\"address\"},{\"name\":\"_subtractedValue\",\"type\":\"uint256\"}],\"name\":\"decreaseApproval\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_owner\",\"type\":\"address\"}],\"name\":\"balanceOf\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_to\",\"type\":\"address\"},{\"name\":\"_value\",\"type\":\"uint256\"}],\"name\":\"transfer\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"_spender\",\"type\":\"address\"},{\"name\":\"_addedValue\",\"type\":\"uint256\"}],\"name\":\"increaseApproval\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"_owner\",\"type\":\"address\"},{\"name\":\"_spender\",\"type\":\"address\"}],\"name\":\"allowance\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"owner\",\"type\":\"address\"},{\"indexed\":true,\"name\":\"spender\",\"type\":\"address\"},{\"indexed\":false,\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"Approval\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"from\",\"type\":\"address\"},{\"indexed\":true,\"name\":\"to\",\"type\":\"address\"},{\"indexed\":false,\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"Transfer\",\"type\":\"event\"}]",
      "bin" : "608060405234801561001057600080fd5b506106ea806100206000396000f30060806040526004361061008d5763ffffffff7c0100000000000000000000000000000000000000000000000000000000600035041663095ea7b3811461009257806318160ddd146100ca57806323b872dd146100f1578063661884631461011b57806370a082311461013f578063a9059cbb14610160578063d73dd62314610184578063dd62ed3e146101a8575b600080fd5b34801561009e57600080fd5b506100b6600160a060020a03600435166024356101cf565b604080519115158252519081900360200190f35b3480156100d657600080fd5b506100df610239565b60408051918252519081900360200190f35b3480156100fd57600080fd5b506100b6600160a060020a036004358116906024351660443561023f565b34801561012757600080fd5b506100b6600160a060020a03600435166024356103bf565b34801561014b57600080fd5b506100df600160a060020a03600435166104b8565b34801561016c57600080fd5b506100b6600160a060020a03600435166024356104d3565b34801561019057600080fd5b506100b6600160a060020a03600435166024356105cc565b3480156101b457600080fd5b506100df600160a060020a036004358116906024351661066e565b600160a060020a03338116600081815260026020908152604080832094871680845294825280832086905580518681529051929493927f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925929181900390910190a350600192915050565b60015490565b6000600160a060020a038316151561025657600080fd5b600160a060020a03841660009081526020819052604090205482111561027b57600080fd5b600160a060020a03808516600090815260026020908152604080832033909416835292905220548211156102ae57600080fd5b600160a060020a0384166000908152602081905260409020546102d7908363ffffffff61069916565b600160a060020a03808616600090815260208190526040808220939093559085168152205461030c908363ffffffff6106ab16565b600160a060020a0380851660009081526020818152604080832094909455878316825260028152838220339093168252919091522054610352908363ffffffff61069916565b600160a060020a038086166000818152600260209081526040808320338616845282529182902094909455805186815290519287169391927fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef929181900390910190a35060019392505050565b600160a060020a0333811660009081526002602090815260408083209386168352929052908120548083111561041c57600160a060020a033381166000908152600260209081526040808320938816835292905290812055610453565b61042c818463ffffffff61069916565b600160a060020a033381166000908152600260209081526040808320938916835292905220555b600160a060020a0333811660008181526002602090815260408083209489168084529482529182902054825190815291517f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b9259281900390910190a35060019392505050565b600160a060020a031660009081526020819052604090205490565b6000600160a060020a03831615156104ea57600080fd5b600160a060020a03331660009081526020819052604090205482111561050f57600080fd5b600160a060020a033316600090815260208190526040902054610538908363ffffffff61069916565b600160a060020a03338116600090815260208190526040808220939093559085168152205461056d908363ffffffff6106ab16565b600160a060020a03808516600081815260208181526040918290209490945580518681529051919333909316927fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef92918290030190a350600192915050565b600160a060020a033381166000908152600260209081526040808320938616835292905290812054610604908363ffffffff6106ab16565b600160a060020a0333811660008181526002602090815260408083209489168084529482529182902085905581519485529051929391927f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b9259281900390910190a350600192915050565b600160a060020a03918216600090815260026020908152604080832093909416825291909152205490565b6000828211156106a557fe5b50900390565b818101828110156106b857fe5b929150505600a165627a7a72305820023e0f83d0d7c222e7bb086167ca7f705738908c80202cb29a676613f5004c650029"
    }
  },
  "version" : "0.4.23+commit.124ca40d.Darwin.appleclang"
};