# SpearDates

SpearDates is a Swift package that provides convenient date handling utilities, reducing common boilerplate code and making date operations more concise and readable.

[![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%2018%20%7C%20macOS%2015-blue.svg)](https://developer.apple.com)
[![GitHub](https://img.shields.io/github/license/kraigspear/SpearDates)](https://github.com/kraigspear/SpearDates/blob/main/LICENSE)

## Requirements

- Swift 6.0+
- iOS 18.0+ / macOS 15.0+

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/kraigspear/SpearDates.git", branch: "main")
]
```

## Features

SpearDates offers a rich set of extensions and utilities for working with dates:

### Date Extraction and Conversion

```swift
// Extract date components
let date = Date()
let components = date.toMonthDayYear()
// Access individual components
let month = components.month
let day = components.day
let year = components.year

// Extract date and time components
let dateTime = date.toMonthDayYearHourMinutesSeconds()
// Access all components
let (month, day, year, hour, minutes, seconds) = dateTime
```

### Date Creation

```swift
// Create a date from components
let specificDate = Date.atGiven(month: 4, day: 23, year: 2025, hour: 14, minute: 30)

// Create a date at a specific percentage of the day (0.0 to 1.0)
let noon = Date(precentOfDay: 0.5) // 12:00 PM
```

### Date Manipulation

```swift
// Add days, hours, or minutes
let tomorrow = Date().addDays(1)
let twoHoursLater = Date().addHours(2)
let thirtyMinutesLater = Date().addMinutes(30)

// Get specific times on a date
let midnight = date.firstHourOfDay
let endOfDay = date.lastHourOfDay
let nineAM = date.atGiven(hour: 9)
```

### Date Comparison

```swift
// Compare dates
let isSameDay = date1.isSameDay(date2)
let isAfter9AM = date.isSameDay(otherDate, hourAtOrAfter: 9)
let isBetween = date.isBetween(startDate, and: endDate)

// Calculate differences
let minutesBetween = date1.numberOfMinutesBetween(date2)
let daysBetween = date1.numberOfDaysBetween(date2)
let minutesSinceNow = date.numberOfMinutesBetweenNow()

// Subtract dates with the operator
let difference = laterDate - earlierDate
// Access components of the difference
let months = difference.month
let days = difference.day
let years = difference.year
```

### Date Formatting

```swift
// Format dates in standard formats
let zuluTime = date.toZuluFormattedString()
let zuluTimeWithMS = DateFormatters.formatZuluWithMilliseconds(date)
let dayOfWeek = DateFormatters.formatDayOfWeek(date)
let shortTime = DateFormatters.formatShortTime(date)
let shortDateTime = DateFormatters.formatShortDateTime(date)

// Format hours with AM/PM
let hourString = DateFormatters.formatHourAmPm(14) // "2 PM"
let customHourFormat = DateFormatters.formatHourAmPm(14, lowerCased: true, spaceBetweenHourAndAmPm: false) // "2pm"
```

## Example

In order to get the Month, Day, and Year of a date, you would typically need to:

1. Create the flags for Month/Day/Year
2. Get those components from a calendar
3. Extract each element, checking for nil

With SpearDates, this code can be simplified to:

```swift
let currentYear = Date().toMonthDayYear().year
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the [MIT License](LICENSE).

## Documentation

For more detailed documentation, visit [SpearDates Documentation](https://kraigspear.github.io/SpearDates/)
