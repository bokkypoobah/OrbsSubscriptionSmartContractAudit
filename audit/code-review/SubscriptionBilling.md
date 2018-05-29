# SubscriptionBilling

Source file [../../contracts/SubscriptionBilling.sol](../../contracts/SubscriptionBilling.sol).

<br />

<hr />

```javascript
// BK Ok
pragma solidity 0.4.23;

// BK Next Ok
import "zeppelin-solidity/contracts/ownership/HasNoContracts.sol";
import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "zeppelin-solidity/contracts/token/ERC20/ERC20.sol";

// BK Ok
import "./DateTime.sol";

/// @title Orbs billing and subscriptions smart contract.
// BK Ok
contract SubscriptionBilling is HasNoContracts {
    // BK Ok
    using SafeMath for uint256;

    // The version of the current SubscriptionBilling smart contract.
    // BK Ok
    string public constant VERSION = "0.1";

    // Maximum number of federation members.
    // BK Ok
    uint public constant MAX_FEDERATION_MEMBERS = 100;

    // The address of the previous deployed OrbsToken smart contract.
    // BK Ok
    ERC20 public orbs;

    // Array of federations members.
    // BK Ok
    address[] public federationMembers;

    // The minimal monthly subscription allocation.
    // BK Ok
    uint public minimalMonthlySubscription;

    // BK Next block Ok
    struct Subscription {
        bytes32 id;
        string profile;
        uint256 startTime;
        uint256 tokens;
    }

    // BK Next block Ok
    struct MonthlySubscriptions {
        mapping(bytes32 => Subscription) subscriptions;
        uint256 totalTokens;
    }

    /// A mapping between time (in a monthly resolution) and subscriptions, in the following format:
    ///     YEAR --> MONTH -->   MONTHLY_SUBSCRIPTION  --> SUBSCRIPTION_ID -->  SUBSCRIPTION
    ///     2017 -->  12   --> {<subscriptions>, 1000} -->     "User1"     --> {"User1", 100}
    // BK TODO
    mapping(uint16 => mapping(uint8 => MonthlySubscriptions)) public subscriptions;

    // BK Ok
    bytes32 constant public EMPTY = bytes32(0);

    // BK Next 2 Ok - Events
    event Subscribed(address indexed subscriber, bytes32 indexed id, uint256 value, uint256 startFrom);
    event DistributedFees(address indexed federationMember, uint256 value);

    /// @dev Constructor that initializes the address of the Orbs billing contract.
    /// @param _orbs ERC20 The address of the previously deployed OrbsToken contract.
    /// @param _federationMembers address[] The public addresses of the federation members.
    /// @param _minimalMonthlySubscription uint256 The minimal monthly subscription allocation.
    // BK Ok - Constructor
    constructor(ERC20 _orbs, address[] _federationMembers,
        uint256 _minimalMonthlySubscription) public {
        // BK Ok
        require(address(_orbs) != address(0), "Address must not be 0!");
        // BK Ok
        require(isFedererationMembersListValid(_federationMembers), "Invalid federation members list!");
        // BK Ok
        require(_minimalMonthlySubscription != 0, "Minimal subscription value must be greater than 0!");

        // BK Next 3 Ok
        orbs = _orbs;
        federationMembers = _federationMembers;
        minimalMonthlySubscription = _minimalMonthlySubscription;
    }

    /// @dev Returns the current month's subscription data.
    /// @param _id bytes32 The ID of the subscription.
    // BK Ok - View function
    function getSubscriptionData(bytes32 _id) public view returns (bytes32 id, string profile, uint256 startTime,
        uint256 tokens) {
        // BK Ok
        require(_id != EMPTY, "ID must not be empty!");

        // Get the current year and month.
        // BK Next 2 Ok
        uint16 currentYear;
        uint8 currentMonth;
        // BK Ok
        (currentYear, currentMonth) = getCurrentTime();

        // BK Ok
        return getSubscriptionDataByTime(_id, currentYear, currentMonth);
    }

    /// @dev Returns the monthly subscription status.
    /// @param _id bytes32 The ID of the subscription.
    /// @param _year uint16 The year of the subscription.
    /// @param _month uint8 The month of the subscription.
    // BK Ok - View function
    function getSubscriptionDataByTime(bytes32 _id, uint16 _year, uint8 _month) public view returns (bytes32 id,
        string profile, uint256 startTime, uint256 tokens) {
        // BK Ok
        require(_id != EMPTY, "ID must not be empty!");

        // BK Ok
        MonthlySubscriptions storage monthlySubscription = subscriptions[_year][_month];
        // BK Ok
        Subscription memory subscription = monthlySubscription.subscriptions[_id];

        // BK Next 4 Ok
        id = subscription.id;
        profile = subscription.profile;
        startTime = subscription.startTime;
        tokens = subscription.tokens;
    }

    /// @dev Distributes monthly fees to federation members.
    // BK Ok - Any account can execute, but tokens only distributed to federationMembers
    function distributeFees() public {
        // Get the current year and month.
        // BK Next 2 Ok
        uint16 currentYear;
        uint8 currentMonth;
        // BK Ok
        (currentYear, currentMonth) = getCurrentTime();

        // BK Ok
        distributeFees(currentYear, currentMonth);
    }

    /// @dev Distributes monthly fees to federation members.
    // BK Ok - Any account can execute, but tokens only distributed to federationMembers
    function distributeFees(uint16 _year, uint8 _month) public {
        // BK Next 2 Ok
        uint16 currentYear;
        uint8 currentMonth;
        // BK Ok
        (currentYear, currentMonth) = getCurrentTime();

        // Don't allow distribution of any future fees (specifically, next month's subscription fees).
        // BK Ok
        require(DateTime.toTimestamp(currentYear, currentMonth) >= DateTime.toTimestamp(_year, _month),
            "Can't distribute future fees!");

        // BK Ok
        MonthlySubscriptions storage monthlySubscription = subscriptions[_year][_month];
        // BK Ok
        uint256 fee = monthlySubscription.totalTokens.div(federationMembers.length);
        // BK Ok
        require(fee > 0, "Fee must be greater than 0!");

        // BK Ok
        for (uint i = 0; i < federationMembers.length; ++i) {
            // BK Ok
            address member = federationMembers[i];
            // BK Ok
            uint256 memberFee = fee;

            // Distribute the remainder to the first node.
            // BK Ok
            if (i == 0) {
                // BK Ok
                memberFee = memberFee.add(monthlySubscription.totalTokens % federationMembers.length);
            }

            // BK Ok
            monthlySubscription.totalTokens = monthlySubscription.totalTokens.sub(memberFee);

            // BK Ok
            require(orbs.transfer(member, memberFee));
            // BK Ok - Log event
            emit DistributedFees(member, memberFee);
        }
    }

    /// @dev Receives subscription payment for the current month. This method needs to be called after the caller
    ///   approves the smart contract to transfer _value ORBS tokens on its behalf.
    /// @param _id bytes32 The ID of the subscription.
    /// @param _profile string The name of the subscription profile. This parameter is ignored for subsequent subscriptions.
    /// @param _value uint256 The amount of tokens to fund the subscription.
    // BK Ok - Any account can subscribe after approving tokens to be transferred from the account to this contract 
    function subscribeForCurrentMonth(bytes32 _id, string _profile, uint256 _value) public {
        // BK Ok
        subscribe(_id, _profile, _value, now);
    }

    /// @dev Receives subscription payment for the next month. This method needs to be called after the caller approves
    /// the smart contract to transfer _value ORBS tokens on its behalf.
    /// @param _id bytes32 The ID of the subscription.
    /// @param _profile string The name of the subscription profile. This parameter is ignored for subsequent subscriptions.
    /// @param _value uint256 The amount of tokens to fund the subscription.
    // BK Ok - Any account can subscribe after approving tokens to be transferred from the account to this contract 
    function subscribeForNextMonth(bytes32 _id, string _profile, uint256 _value) public {
        // Get the current year and month.
        // BK Next 2 Ok
        uint16 currentYear;
        uint8 currentMonth;
        // BK Ok
        (currentYear, currentMonth) = getCurrentTime();

        // Get the next month.
        // BK Next 2 Ok
        uint16 nextYear;
        uint8 nextMonth;
        // BK Ok
        (nextYear, nextMonth) = DateTime.getNextMonth(currentYear, currentMonth);

        // BK Ok
        subscribe(_id, _profile, _value, DateTime.getBeginningOfMonth(nextYear, nextMonth));
    }

    /// @dev Receives subscription payment. This method needs to be called after the caller approves
    /// the smart contract to transfer _value ORBS tokens on its behalf.
    /// @param _id bytes32 The ID of the subscription.
    /// @param _profile string The name of the subscription profile. This parameter is ignored for subsequent subscriptions.
    /// @param _value uint256 The amount of tokens to fund the subscription.
    /// @param _startTime uint256 The start time of the subscription.
    // BK Ok - Internal function
    function subscribe(bytes32 _id, string _profile, uint256 _value, uint256 _startTime) internal {
        // BK Ok
        require(_id != EMPTY, "ID must not be empty!");
        // BK Ok
        require(bytes(_profile).length > 0, "Profile must not be empty!");
        // BK Ok
        require(_value > 0, "Value must be greater than 0!");
        // BK Ok
        require(_startTime >= now, "Starting time must be in the future");

        // Verify that the subscriber approved enough tokens to pay for the subscription.
        // BK Ok
        require(orbs.transferFrom(msg.sender, address(this), _value), "Insufficient allowance!");

        // BK Next 2 Ok
        uint16 year;
        uint8 month;
        // BK Ok
        (year, month) = getTime(_startTime);

        // Get the subscription.
        // BK Ok
        MonthlySubscriptions storage monthlySubscription = subscriptions[year][month];
        // BK Ok
        Subscription storage subscription = monthlySubscription.subscriptions[_id];

        // New subscription?
        // BK Ok
        if (subscription.id == EMPTY) {
            // BK Next 3 Ok
            subscription.id = _id;
            subscription.profile = _profile;
            subscription.startTime = _startTime;
        }

        // Aggregate this month's subscription allocations.
        // BK Ok
        subscription.tokens = subscription.tokens.add(_value);

        // Make sure that the total monthly subscription allocation is above the minimal requirement.
        // BK NOTE - Only the first subscription has to exceed the `minimalMonthlySubscription`.
        // BK NOTE - After the first subscription tx is made, subsequent subscription txs will always pass this check
        // BK Ok
        require(subscription.tokens >= minimalMonthlySubscription, "Subscription value is too low!");

        // Update selected month's total subscription allocations.
        // BK Ok
        monthlySubscription.totalTokens = monthlySubscription.totalTokens.add(_value);

        // BK Ok - Log event
        emit Subscribed(msg.sender, _id, _value, _startTime);
    }

    /// @dev Returns the current year and month.
    /// @return year uint16 The current year.
    /// @return month uint8 The current month.
    // BK Ok - View function
    function getCurrentTime() private view returns (uint16 year, uint8 month) {
        // BK Ok
        return getTime(now);
    }

    /// @dev Returns the current year and month.
    /// @param _time uint256 The timestamp of the time to query.
    /// @return year uint16 The current year.
    /// @return month uint8 The current month.
    // BK Ok - Pure function
    function getTime(uint256 _time) private pure returns (uint16 year, uint8 month) {
        // BK Ok
        year = DateTime.getYear(_time);
        // BK Ok
        month = DateTime.getMonth(_time);
    }

    /// @dev Checks federation members list for correctness.
    /// @param _federationMembers address[] The federation members list to check.
    // BK Ok - Private pure function
    function isFedererationMembersListValid(address[] _federationMembers) private pure returns (bool) {
        // BK Ok
        if (_federationMembers.length == 0 || _federationMembers.length > MAX_FEDERATION_MEMBERS) {
            // BK Ok
            return false;
        }

        // Make sure there are no zero addresses or duplicates in the federation members list.
        // BK Ok
        for (uint i = 0; i < _federationMembers.length - 1; ++i) {
            // BK Ok
            if (_federationMembers[i] == address(0)) {
                // BK Ok
                return false;
            }

            // BK Ok
            for (uint j = i + 1; j < _federationMembers.length; ++j) {
                // BK Ok
                if (_federationMembers[i] == _federationMembers[j]) {
                    // BK Ok
                    return false;
                }
            }
        }

        // BK Ok
        return true;
    }
}

```
