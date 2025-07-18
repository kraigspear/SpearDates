//
//  DateExtensions.swift
//  SpearSwiftLib
//
//  Created by Kraig Spear on 10/9/15.
//  Copyright © 2015 spearware. All rights reserved.
//

import Foundation
import SpearFoundation

/// Operator to subtract dates
/// - Parameters:
///   - left: Left side
///   - right: Right side
/// - Returns: Result of subtracting two dates
public func - (left: Date, right: Date) -> (month: Int, day: Int, year: Int, hour: Int, minute: Int, second: Int) {
    left.subtractDate(right)
}

public extension Date {
    // MARK: - Date Time Const

    static var numberOfMinutesInDay: Int { 1440 }
    static var minutesInHour: Int { 60 }

    // MARK: - Extensions

    /**
     Adds a certain number of days to this date

     - Parameter numberOfDays: The number of days to add

     - Returns: A new date with numberOfDays added

     ```swift
     let oct172015 = NSDate(timeIntervalSince1970: 1445077917)
     let aDayLater = oct172015.addDays(1)
     let mdy = aDayLater.toMonthDayYear()
     XCTAssertEqual(18, mdy.day)
     ```

     */
    @available(*, deprecated, message: "Use Calendar.current.date(byAdding: .day, value: numberOfDays, to: self) instead")
    func addDays(_ numberOfDays: Int) -> Date {
        var dayComponent = DateComponents()
        dayComponent.day = numberOfDays
        let calendar = Calendar.current
        return calendar.date(byAdding: dayComponent, to: self)!
    }

    /** Adds a certain number of minutes to this date
     - Parameter numberOfMinutes: Number of minutes to add
     - Returns: Date with the minutes added
     **/
    @available(*, deprecated, message: "Use Calendar.current.date(byAdding: .minute, value: numberOfMinutes, to: self) instead")
    func addMinutes(_ numberOfMinutes: Int) -> Date {
        var dayComponent = DateComponents()
        dayComponent.minute = numberOfMinutes
        let calendar = Calendar.current
        return calendar.date(byAdding: dayComponent, to: self)!
    }

    /** Adds a certain number of hours to this date
     - Parameter numberOfHours: Number of hours to add
     - Returns: Date with the minutes added
     **/
    @available(*, deprecated, message: "Use Calendar.current.date(byAdding: .hour, value: numberOfHours, to: self) instead")
    func addHours(_ numberOfHours: Int) -> Date {
        var dayComponent = DateComponents()
        dayComponent.hour = numberOfHours
        let calendar = Calendar.current
        return calendar.date(byAdding: dayComponent, to: self)!
    }

    /**
     Is this day the same day as the other date? Ignoring time

     - Parameter date: The date to compare this time with

     - Returns: true if the two days occur on the same day
     */
    @available(*, deprecated, message: "Use Calendar.current.isDate(self, inSameDayAs: date) instead")
    func isSameDay(_ date: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: date)
    }

    func isSameDay(
        _ otherDate: Date,
        hourAtOrAfter: Int
    ) -> Bool {
        let calendar = Calendar.current
        // Check if it's the same day
        guard calendar.isDate(self, inSameDayAs: otherDate) else {
            return false
        }
        let hour = calendar.component(.hour, from: self)
        return hour >= hourAtOrAfter
    }

    /// Subtract two dates and return them as a tuple.
    ///
    /// - Parameter otherDate: The other date to compare with
    ///
    /// - Returns: The difference in the two dates as m/d/y/h/m/s
    func subtractDate(_ otherDate: Date) -> (month: Int, day: Int, year: Int, hour: Int, minute: Int, second: Int) {
        let calendar = Calendar.current

        let types: Set<Calendar.Component> = [
            Calendar.Component.month,
            Calendar.Component.day,
            Calendar.Component.year,
            Calendar.Component.hour,
            Calendar.Component.minute,
            Calendar.Component.second,
        ]

        let dateComponents = calendar.dateComponents(types, from: self, to: otherDate)

        return (month: abs(dateComponents.month!),
                day: abs(dateComponents.day!),
                year: abs(dateComponents.year!),
                hour: abs(dateComponents.hour!),
                minute: abs(dateComponents.minute!),
                second: abs(dateComponents.second!))
    }

    /**
     Extract out the m/d/y/h/m/s parts of a date into a Tuple

     - Returns: A tuple as three ints that include month day year
     */
    func toMonthDayYearHourMinutesSeconds() -> (month: Int, day: Int, year: Int, hour: Int, minutes: Int, seconds: Int) {
        let flags: Set<Calendar.Component> = [.month, .day, .year, .hour, .minute, .second]
        let components = Calendar.current.dateComponents(flags, from: self)

        let m = components.month!
        let d = components.day!
        let y = components.year!
        let h = components.hour!
        let min = components.minute!
        let s = components.second!

        return (month: m, day: d, year: y, hour: h, minutes: min, seconds: s)
    }

    /**
     Extract out the m/d/y parts of a date into a Tuple

     - Returns: A tuple as three ints that include month day year
     */
    func toMonthDayYear() -> (month: Int, day: Int, year: Int) {
        let flags: Set<Calendar.Component> = [
            Calendar.Component.month,
            Calendar.Component.day,
            Calendar.Component.year,
        ]

        let components = Calendar.current.dateComponents(flags, from: self)
        let m = components.month!
        let d = components.day!
        let y = components.year!
        return (month: m, day: d, year: y)
    }

    /**
     Converts this date to the Julian Day
     */
    func toJulianDayNumber() -> Double {
        let components = toMonthDayYear()

        let a = floor(Double((14 - components.month) / 12))
        let y = Double(components.year) + 4800.0 - a
        let m = Double(components.month) + 12.0 * a - 3.0

        var f: Double = (153.0 * m + 2.0) / 5.0
        f += 365.0 * y
        f += floor(y / 4.0)
        f -= floor(y / 100.0)
        f += floor(y / 400.0)
        f -= 32045

        let jdn = Double(components.day) + f

        return jdn
    }

    /**
     Creates a date from the provided date components
     - parameter month: The month of the date to create
     - parameter day: The day of the date to create
     - parameter year: The year of the date to create
     - returns: The date from the provided components using the current calendar or nil, if the date could not be created
     */
    @available(*, deprecated, message: "Use Calendar.current.date(from: DateComponents(year: year, month: month, day: day)) instead")
    static func fromMonth(_ month: Int, day: Int, year: Int) -> Date? {
        var components = DateComponents()
        components.month = month
        components.day = day
        components.year = year
        return Calendar.current.date(from: components)
    }

    /**
     Is this date between startDate and endDate
     - parameter startDate: The start date to compare
     - parameter and: The end date to compare
     */
    func isBetween(_ startDate: Date, and endDate: Date) -> Bool {
        timeIntervalSinceReferenceDate >= startDate.timeIntervalSinceReferenceDate &&
            timeIntervalSinceReferenceDate <= endDate.timeIntervalSinceReferenceDate
    }

    /**
     How many minutes have passed between this date and `otherDate`
     - parameter otherDate: Date to compare this date to
     */
    @available(*, deprecated, message: "Use abs(Calendar.current.dateComponents([.minute], from: self, to: otherDate).minute ?? 0) instead")
    func numberOfMinutesBetween(_ otherDate: Date) -> Int {
        let calendarUnit: Set<Calendar.Component> = [Calendar.Component.minute]
        let difference = Calendar.current.dateComponents(calendarUnit, from: self, to: otherDate)
        return abs(difference.minute!)
    }

    func numberOfDaysBetween(_ otherDate: Date = Date()) -> Int {
        let calendarUnit: Set<Calendar.Component> = [Calendar.Component.day]
        let difference = Calendar.current.dateComponents(calendarUnit, from: self, to: otherDate)
        return abs(difference.day!)
    }

    /**
     How many minutes have passed between this date and the current date
     - parameter otherDate: Date to compare this date to
     */
    @available(*, deprecated, message: "Use numberOfMinutesBetween(Date()) or abs(Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0) instead")
    func numberOfMinutesBetweenNow() -> Int {
        numberOfMinutesBetween(Date())
    }

    /**
     Convert this date to a string formatted as Zulu date

     - returns: Date formatted as a Zulu date
     - seealso: String.toDateFromZulu()
     */
    func toZuluFormattedString() -> String {
        DateFormatters.formatZulu(self)
    }

    /// Midnight on this date
    @available(*, deprecated, message: "Use Calendar.current.startOfDay(for: self) instead")
    var firstHourOfDay: Date {
        let flags: Set<Calendar.Component> = [
            Calendar.Component.month,
            Calendar.Component.day,
            Calendar.Component.year,
        ]

        var components = Calendar.current.dateComponents(flags, from: self)
        components.hour = 0
        components.minute = 0
        components.second = 0

        return Calendar.current.date(from: components)!
    }

    /// The last hour, minute, second of this day
    var lastHourOfDay: Date {
        let flags: Set<Calendar.Component> = [
            Calendar.Component.month,
            Calendar.Component.day,
            Calendar.Component.year,
        ]

        var components = Calendar.current.dateComponents(flags, from: self)
        components.hour = 23
        components.minute = 59
        components.second = 59

        return Calendar.current.date(from: components)!
    }

    /// Connivance property for readability to encourage one way to get epoch. `timeIntervalSince1970`
    @available(*, deprecated, message: "Use timeIntervalSince1970 directly instead")
    var epoch: TimeInterval { timeIntervalSince1970 }

    /// What minute of the day for this Date
    var minuteOfDay: Int {
        let hourMinutes = Calendar.current.dateComponents([.hour, .minute], from: self)
        return (hourMinutes.hour! * Date.minutesInHour) + hourMinutes.minute!
    }

    /// What percentage of the day has passed expressed from 0.0 to 1.0
    /// Example 12:00 PM would be .5
    var percentOfDay: Double {
        Double(minuteOfDay) / Double(Date.numberOfMinutesInDay)
    }

    /**
     Create a date using today at a given percent with a range of 0.0 to 1.0
     - parameter percentOfDay
     Example: 0.5
     */
    init(@Clamped(range: 0.0 ... 1.0) percentOfDay: Double) {
        let numberOfMinutesInDay = 60.0 * 24.0

        let minutesForPercent = percentOfDay * numberOfMinutesInDay
        let hours = minutesForPercent / 60.0
        let minutesPct = hours.truncatingRemainder(dividingBy: 1.0)
        let remainingMinutes = minutesPct * 60.0

        self = Date.now.atGiven(hour: Int(hours), minute: Int(remainingMinutes))!
    }

    /**
     Given this date, return another date with the given hour, minute and second
     or nil if the date could not be created.
     A Date might not be created if the inputs are invalid such as invalid minute.

     - returns: A new Date, or nil if a date could not be found which matches the components.

     - parameters:
     - hour: The hour (0 - 23) of the day to give to this time
     - minute: The minute of a given day 0 - 59
     - second: The second of the given day 0 - 59
     */
    func atGiven(hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date? {
        let flags: Set<Calendar.Component> = [.month, .day, .year, .hour, .minute, .second]
        var components = Calendar.current.dateComponents(flags, from: self)

        components.hour = hour
        components.minute = minute
        components.second = second

        return Calendar.current.date(from: components)
    }

    /// Creates a `Date` instance for the specified date and time components.
    ///
    /// This method creates a `Date` object using the provided date and time components.
    /// The time components (hour, minute, and second) are optional and default to 0 if not specified.
    ///
    /// - Parameters:
    ///   - month: The month of the year (1-12).
    ///   - day: The day of the month (1-31).
    ///   - year: The year.
    ///   - hour: The hour of the day (0-23). Defaults to 0.
    ///   - minute: The minute of the hour (0-59). Defaults to 0.
    ///   - second: The second of the minute (0-59). Defaults to 0.
    ///
    /// - Returns: A `Date` instance representing the specified date and time,
    ///            or `nil` if the date cannot be created from the given components.
    ///
    /// - Note: This method uses the current calendar and time zone settings.
    ///
    /// - Example:
    ///   ```swift
    ///   if let date = Date.atGiven(month: 9, day: 20, year: 2024, hour: 14, minute: 30) {
    ///       print(date)
    ///   }
    ///   ```
    static func atGiven(month: Int,
                        day: Int,
                        year: Int,
                        hour: Int = 0,
                        minute: Int = 0,
                        second: Int = 0) -> Self? {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        return Calendar.current.date(from: components)
    }

    func replacingDay(with replacingWith: Date = Date()) -> Date {
        let monthDayYear = replacingWith.toMonthDayYear()

        let flags: Set<Calendar.Component> = [.month, .day, .year, .hour, .minute, .second]
        var components = Calendar.current.dateComponents(flags, from: self)

        components.month = monthDayYear.month
        components.day = monthDayYear.day
        components.year = monthDayYear.year

        return Calendar.current.date(from: components)!
    }
}
