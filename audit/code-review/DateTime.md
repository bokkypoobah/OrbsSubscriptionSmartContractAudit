# DateTime

Source file [../../contracts/DateTime.sol](../../contracts/DateTime.sol).

<br />

<hr />

```javascript
// BK Ok
pragma solidity 0.4.23;

// BK Ok
import "zeppelin-solidity/contracts/math/SafeMath.sol";


/// @title Date and Time utilities for Ethereum contracts.
// BK Ok
library DateTime {
    // BK Next 3 Ok
    using SafeMath for uint256;
    using SafeMath for uint16;
    using SafeMath for uint8;

    // BK Next block Ok
    struct DT {
        uint16 year;
        uint8 month;
        uint8 day;
        uint8 hour;
        uint8 minute;
        uint8 second;
        uint8 weekday;
    }

    // BK Ok - 24 * 60 * 60 = 86,400
    uint public constant SECONDS_IN_DAY = 86400;
    // BK Ok - 365 * 24 * 60 * 60 = 31,536,000
    uint public constant SECONDS_IN_YEAR = 31536000;
    // BK Ok - 366 * 24 * 60 * 60 = 31,622,400
    uint public constant SECONDS_IN_LEAP_YEAR = 31622400;
    // BK Ok
    uint public constant DAYS_IN_WEEK = 7;
    // BK Ok
    uint public constant HOURS_IN_DAY = 24;
    // BK Ok
    uint public constant MINUTES_IN_HOUR = 60;
    // BK Ok - 60 * 60 = 3,600
    uint public constant SECONDS_IN_HOUR = 3600;
    // BK Ok
    uint public constant SECONDS_IN_MINUTE = 60;

    // BK Ok - Unixtime 01/01/1970 00:00:00 UTC
    uint16 public constant ORIGIN_YEAR = 1970;

    /// @dev Returns whether the specified year is a leap year.
    /// @param _year uint16 The year to check.
    // BK Ok - Pure function
    function isLeapYear(uint16 _year) public pure returns (bool) {
        // BK Ok - Every 4 years
        if (_year % 4 != 0) {
            // BK Ok
            return false;
        }

        // BK Ok - But not multiples of 100
        if (_year % 100 != 0) {
            // BK Ok
            return true;
        }

        // BK Ok - Except for multiples of 400
        if (_year % 400 != 0) {
            // BK Ok
            return false;
        }

        // BK Ok
        return true;
    }

    /// @dev Returns how many leap years were before the specified year.
    /// @param _year uint16 The year to check.
    // BK Ok - Pure function
    function leapYearsBefore(uint16 _year) public pure returns (uint16) {
        // BK Ok
        _year = uint16(_year.sub(1));
        // BK Ok
        return uint16(_year.div(4).sub(_year.div(100)).add(_year.div(400)));
    }

    /// @dev Returns how many days are there in a specified month.
    /// @param _year uint16 The year of the month to check.
    /// @param _month uint8 The month to check.
    // BK Ok - Pure function
    function getDaysInMonth(uint16 _year, uint8 _month) public pure returns (uint8) {
        // BK Ok
        if (_month == 1 || _month == 3 || _month == 5 || _month == 7 || _month == 8 || _month == 10 || _month == 12) {
            // BK Ok
            return 31;
        }

        // BK Ok
        if (_month == 4 || _month == 6 || _month == 9 || _month == 11) {
            // BK Ok
            return 30;
        }

        // BK Ok
        if (isLeapYear(_year)) {
            // BK Ok
            return 29;
        }

        // BK Ok
        return 28;
    }

    /// @dev Returns the year of the current UNIX timestamp.
    /// @param _timestamp uint256 The UNIX timestamp to parse.
    // BK Ok - Pure function
    function getYear(uint256 _timestamp) public pure returns (uint16 year) {
        // BK Ok
        uint256 secondsAccountedFor;
        // BK Ok
        uint16 numLeapYears;

        // Year
        // BK Ok
        year = uint16(ORIGIN_YEAR.add(_timestamp.div(SECONDS_IN_YEAR)));
        // BK Ok
        numLeapYears = uint16(leapYearsBefore(year).sub(leapYearsBefore(ORIGIN_YEAR)));

        // BK Ok
        secondsAccountedFor = secondsAccountedFor.add(SECONDS_IN_LEAP_YEAR.mul(numLeapYears));
        // BK Ok
        secondsAccountedFor = secondsAccountedFor.add(SECONDS_IN_YEAR.mul((year.sub(ORIGIN_YEAR).sub(numLeapYears))));

        // BK Ok
        while (secondsAccountedFor > _timestamp) {
            // BK Ok
            if (isLeapYear(uint16(year.sub(1)))) {
                // BK Ok
                secondsAccountedFor = secondsAccountedFor.sub(SECONDS_IN_LEAP_YEAR);
            // BK Ok
            } else {
                // BK Ok
                secondsAccountedFor = secondsAccountedFor.sub(SECONDS_IN_YEAR);
            }

            // BK Ok
            year = uint16(year.sub(1));
        }
    }

    /// @dev Returns the month of the current UNIX timestamp.
    /// @param _timestamp uint256 The UNIX timestamp to parse.
    // BK Ok - Pure function
    function getMonth(uint256 _timestamp) public pure returns (uint8) {
        // BK Ok
        return parseTimestamp(_timestamp).month;
    }

    /// @dev Returns the day of the current UNIX timestamp.
    /// @param _timestamp uint256 The UNIX timestamp to parse.
    // BK Ok - Pure function
    function getDay(uint256 _timestamp) public pure returns (uint8) {
        // BK Ok
        return parseTimestamp(_timestamp).day;
    }

    /// @dev Returns the hour of the current UNIX timestamp.
    /// @param _timestamp uint256 The UNIX timestamp to parse.
    // BK Ok - Pure function
    function getHour(uint256 _timestamp) public pure returns (uint8) {
        // BK Ok
        return uint8((_timestamp.div(SECONDS_IN_HOUR)) % HOURS_IN_DAY);
    }

    /// @dev Returns the minutes of the current UNIX timestamp.
    /// @param _timestamp uint256 The UNIX timestamp to parse.
    // BK Ok - Pure function
    function getMinute(uint256 _timestamp) public pure returns (uint8) {
        // BK Ok
        return uint8((_timestamp.div(SECONDS_IN_MINUTE)) % MINUTES_IN_HOUR);
    }

    /// @dev Returns the seconds of the current UNIX timestamp.
    /// @param _timestamp uint256 The UNIX timestamp to parse.
    // BK Ok - Pure function
    function getSecond(uint256 _timestamp) public pure returns (uint8) {
        // BK Ok
        return uint8(_timestamp % SECONDS_IN_MINUTE);
    }

    /// @dev Returns the weekday of the current UNIX timestamp.
    /// @param _timestamp uint256 The UNIX timestamp to parse.
    // BK Ok - Pure function
    function getWeekday(uint256 _timestamp) public pure returns (uint8) {
        // BK Ok
        return uint8((_timestamp.div(SECONDS_IN_DAY).add(4)) % DAYS_IN_WEEK);
    }

    /// @dev Returns the timestamp of the beginning of the month.
    /// @param _month uint8 The month to check.
    /// @param _year uint16 The year of the month to check.
    // BK Ok - Pure function
    function getBeginningOfMonth(uint16 _year, uint8 _month) public pure returns (uint256) {
        // BK Ok
        return toTimestamp(_year, _month, 1);
    }

    /// @dev Returns the timestamp of the beginning of the month.
    /// @param _month uint8 The month to check.
    /// @param _year uint16 The year of the month to check.
    // BK Ok - Pure function
    function getNextMonth(uint16 _year, uint8 _month) public pure returns (uint16 year, uint8 month) {
        // BK Ok
        if (_month == 12) {
            // BK Ok
            year = uint16(_year.add(1));
            // BK Ok
            month = 1;
        // BK Ok
        } else {
            // BK Ok
            year = _year;
            // BK Ok
            month = uint8(_month.add(1));
        }
    }

    /// @dev Converts date to timestamp.
    /// @param _year uint16 The year of the date.
    /// @param _month uint8 The month of the date.
    // BK Ok - Pure function
    function toTimestamp(uint16 _year, uint8 _month) public pure returns (uint) {
        // BK NOTE - The day of 0 is the same as the day of 1 in toTimestamp(...)
        // BK Ok
        return toTimestamp(_year, _month, 0, 0, 0, 0);
    }

    /// @dev Converts date to timestamp.
    /// @param _year uint16 The year of the date.
    /// @param _month uint8 The month of the date.
    /// @param _day uint8 The day of the date.
    // BK Ok - Pure function
    function toTimestamp(uint16 _year, uint8 _month, uint8 _day) public pure returns (uint) {
        // BK Ok
        return toTimestamp(_year, _month, _day, 0, 0, 0);
    }

    /// @dev Converts date to timestamp.
    /// @param _year uint16 The year of the date.
    /// @param _month uint8 The month of the date.
    /// @param _day uint8 The day of the date.
    /// @param _hour uint8 The hour of the date.
    /// @param _minutes uint8 The minutes of the date.
    /// @param _seconds uint8 The seconds of the date.
    // BK Ok - Pure function
    function toTimestamp(uint16 _year, uint8 _month, uint8 _day, uint8 _hour, uint8 _minutes,
        uint8 _seconds) public pure returns (uint256 timestamp) {
        // BK Ok
        uint16 i;

        // Year
        // BK Ok
        for (i = ORIGIN_YEAR; i < _year; ++i) {
            // BK Ok
            if (isLeapYear(i)) {
                // BK Ok
                timestamp = timestamp.add(SECONDS_IN_LEAP_YEAR);
            // BK Ok
            } else {
                // BK Ok
                timestamp = timestamp.add(SECONDS_IN_YEAR);
            }
        }

        // Month
        // BK Ok
        uint8[12] memory monthDayCounts;
        // BK Ok
        monthDayCounts[0] = 31;
        // BK Ok
        if (isLeapYear(_year)) {
            // BK Ok
            monthDayCounts[1] = 29;
        // BK Ok
        } else {
            // BK Ok
            monthDayCounts[1] = 28;
        }
        // BK Next 10 Ok
        monthDayCounts[2] = 31;
        monthDayCounts[3] = 30;
        monthDayCounts[4] = 31;
        monthDayCounts[5] = 30;
        monthDayCounts[6] = 31;
        monthDayCounts[7] = 31;
        monthDayCounts[8] = 30;
        monthDayCounts[9] = 31;
        monthDayCounts[10] = 30;
        monthDayCounts[11] = 31;

        // BK Ok
        for (i = 1; i < _month; ++i) {
            // BK Ok
            timestamp = timestamp.add(SECONDS_IN_DAY.mul(monthDayCounts[i.sub(1)]));
        }

        // Day
        // BK NOTE - Day 0 is the same as day 1
        // BK Ok
        timestamp = timestamp.add(SECONDS_IN_DAY.mul(_day == 0 ? 0 : _day.sub(1)));

        // Hour
        // BK Ok
        timestamp = timestamp.add(SECONDS_IN_HOUR.mul(_hour));

        // Minutes
        // BK Ok
        timestamp = timestamp.add(SECONDS_IN_MINUTE.mul(_minutes));

        // Seconds
        // BK Ok
        timestamp = timestamp.add(_seconds);
    }

    /// @dev Parses a UNIX timestamp to a DT struct.
    /// @param _timestamp uint256 The UNIX timestamp to parse.
    // BK Ok - Internal pure function. Called by getMonth(...) and getDay(...)
    function parseTimestamp(uint256 _timestamp) internal pure returns (DT dt) {
        // BK Next 3 Ok
        uint256 secondsAccountedFor;
        uint256 buf;
        uint8 i;

        // Year
        // BK Ok
        dt.year = getYear(_timestamp);
        // BK Ok - Number of leap years
        buf = leapYearsBefore(dt.year) - leapYearsBefore(ORIGIN_YEAR);

        // BK Ok - Add seconds for each leap year
        secondsAccountedFor = secondsAccountedFor.add(SECONDS_IN_LEAP_YEAR.mul(buf));
        // BK Ok - Add seconds for each (non-leap-year - leap year)
        secondsAccountedFor = secondsAccountedFor.add(SECONDS_IN_YEAR.mul((dt.year.sub(ORIGIN_YEAR).sub(buf))));

        // Month
        // BK Ok
        uint256 secondsInMonth;
        // BK Ok
        for (i = 1; i <= 12; ++i) {
            // BK Ok
            secondsInMonth = SECONDS_IN_DAY.mul(getDaysInMonth(dt.year, i));
            // BK Ok
            if (secondsInMonth.add(secondsAccountedFor) > _timestamp) {
                // BK Ok
                dt.month = i;
                // BK Ok
                break;
            }
            // BK Ok
            secondsAccountedFor = secondsAccountedFor.add(secondsInMonth);
        }

        // Day
        // BK Ok
        for (i = 1; i <= getDaysInMonth(dt.year, dt.month); ++i) {
            // BK Ok
            if (SECONDS_IN_DAY.add(secondsAccountedFor) > _timestamp) {
                // BK Ok
                dt.day = i;
                // BK Ok
                break;
            }
            // BK Ok
            secondsAccountedFor = secondsAccountedFor.add(SECONDS_IN_DAY);
        }

        // Hour
        // BK Ok
        dt.hour = getHour(_timestamp);

        // Minute
        // BK Ok
        dt.minute = getMinute(_timestamp);

        // Second
        // BK Ok
        dt.second = getSecond(_timestamp);

        // Day of week.
        // BK Ok
        dt.weekday = getWeekday(_timestamp);
    }
}

```
