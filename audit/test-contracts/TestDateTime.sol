pragma solidity ^0.4.23;

import "./DateTime.sol";

contract TestDateTime {
    using SafeMath for uint256;

    function fromTimestamp(uint256 _time) public pure returns (uint16 year, uint8 month, uint8 day, uint8 hour, uint8 minute, uint8 second) {
        year = DateTime.getYear(_time);
        month = DateTime.getMonth(_time);
        day = DateTime.getDay(_time);
        hour = DateTime.getHour(_time);
        minute = DateTime.getMinute(_time);
        second = DateTime.getSecond(_time);
    }

    function toTimestamp(uint16 _year, uint8 _month, uint8 _day, uint8 _hour, uint8 _minutes, uint8 _seconds) public pure returns (uint256 timestamp) {
        return DateTime.toTimestamp(_year, _month, _day, _hour, _minutes, _seconds);
    }

    function toTimestampYYYYMM(uint16 _year, uint8 _month) public pure returns (uint) {
        return DateTime.toTimestamp(_year, _month);
    }

    function toTimestampYYYYMMDD(uint16 _year, uint8 _month, uint8 _day) public pure returns (uint) {
        return DateTime.toTimestamp(_year, _month, _day);
    }
}