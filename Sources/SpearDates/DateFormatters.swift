import Foundation
import SpearFoundation

/// An enumeration that defines various date format styles for consistent presentation.
///
/// `DateFormat` provides a collection of commonly used date formatting patterns
/// that can be applied to `Date` objects. Each case represents a specific formatting
/// style that determines how time components are displayed.
///
/// The enum includes a `format(_:in:)` method that applies the selected format to
/// a given date in the specified time zone.
///
/// # Available Format Styles
///
/// - `hmm_a`: Hour and minute with AM/PM designation (e.g., "9:30 AM")
/// - `ha`: Hour with AM/PM designation (e.g., "9 AM")
/// - `hmm`: Hour and minute in 24-hour format (e.g., "14:30")
/// - `dayOfWeek`: Full name of the day of week (e.g., "Wednesday")
///
/// # Usage
///
/// ```swift
/// let now = Date()
/// let timeString = DateFormat.hmm_a.format(now, in: .current)
/// // Returns something like "2:30 PM"
///
/// let dayName = DateFormat.dayOfWeek.format(now, in: .current)
/// // Returns something like "Wednesday"
/// ```
///
/// All formats respect the user's locale settings and follow
/// standard formatting conventions for the specified time zone.
public enum DateFormat {
    case hmm_a
    case ha
    case hmm
    case dayOfWeek

    func format(_ date: Date, in timeZone: Date.FormatStyle.Symbol.TimeZone) -> String {
        date.formatted(
            .dateTime
                .hour()
                .minute()
                .weekday(.wide)
                .timeZone(timeZone)
                .locale(Locale.current)
                .hour(.defaultDigits(amPM: .abbreviated))
        )
    }
}

/// A collection of utility methods for formatting dates in various standardized formats.
///
/// `DateFormatters` provides a set of static methods to convert `Date` objects into
/// formatted strings according to common presentation needs. These formats include:
/// - ISO8601/Zulu time formats (with and without milliseconds)
/// - Day of week formatting
/// - Short time and date-time presentations
/// - Hour formatting with AM/PM designations
///
/// # Usage
///
/// Format a date in ISO8601/Zulu format:
/// ```swift
/// let now = Date()
/// let zuluTime = DateFormatters.formatZulu(now)
/// // Returns something like "2025-04-23T14:30:00Z"
/// ```
///
/// Format a date showing only the day of week:
/// ```swift
/// let now = Date()
/// let dayName = DateFormatters.formatDayOfWeek(now)
/// // Returns something like "Wednesday"
/// ```
///
/// Format an hour with AM/PM designation:
/// ```swift
/// let hourString = DateFormatters.formatHourAmPm(14)
/// // Returns "2 PM"
/// ```
///
/// All formatters respect the user's locale settings where appropriate
/// and follow best practices for date and time formatting.
public enum DateFormatters {
    public static func formatZulu(_ date: Date) -> String {
        date.formatted(
            .iso8601
                .year()
                .month()
                .day()
                .dateSeparator(.dash)
                .time(includingFractionalSeconds: false)
                .timeSeparator(.colon)
                .timeZone(separator: .colon)
        )
    }

    public static func formatZuluWithMilliseconds(_ date: Date) -> String {
        date.formatted(
            .iso8601
                .year()
                .month()
                .day()
                .dateSeparator(.dash)
                .time(includingFractionalSeconds: true)
                .timeSeparator(.colon)
                .timeZone(separator: .colon)
        )
    }

    public static func formatDayOfWeek(_ date: Date) -> String {
        date.formatted(.dateTime.weekday(.wide))
    }

    public static func formatShortTime(_ date: Date) -> String {
        date.formatted(.dateTime.hour().minute())
    }

    public static func formatShortDateTime(_ date: Date) -> String {
        date.formatted(
            .dateTime
                .year()
                .month()
                .day()
                .hour()
                .minute()
        )
    }

    /// Formats an hour as a string with AM/PM designation.
    ///
    /// This method converts an integer hour value (in 24-hour format) to a formatted string with AM/PM designation.
    /// The function allows customization of the output's casing and spacing.
    ///
    /// - Parameters:
    ///   - hour: An integer representing the hour in 24-hour format (0-23). This parameter is clamped to ensure it falls within valid hour range.
    ///   - lowerCased: A Boolean value that determines whether the AM/PM designation should be lowercase. The default is `false`.
    ///   - spaceBetweenHourAndAmPm: A Boolean value that determines whether there should be a space between the hour and the AM/PM designation. The default is `true`.
    ///
    /// - Returns: A formatted string representing the hour with AM/PM designation.
    ///
    /// # Examples
    ///
    ///   ```swift
    ///   // Format regular hour with default settings (uppercase AM/PM with space)
    ///   let morningHour = DateFormatters.formatHourAmPm(9)
    ///   // Returns "9 AM"
    ///
    ///   // Format afternoon hour with lowercase AM/PM and no space
    ///   let afternoonHour = DateFormatters.formatHourAmPm(17, lowerCased: true, spaceBetweenHourAndAmPm: false)
    ///   // Returns "5pm"
    ///
    ///   // Format noon with default settings
    ///   let noonHour = DateFormatters.formatHourAmPm(12)
    ///   // Returns "12 PM"
    ///   ```
    public static func formatHourAmPm(
        @Clamped(range: 0 ... 23) _ hour: Int,
        lowerCased: Bool = false,
        spaceBetweenHourAndAmPm: Bool = true
    ) -> String {
        let dateAtHour = Date().dateWithHourSetTo(hour)
        var hourAsString = dateAtHour.formatted(
            .dateTime
                .hour()
                .minute(.omitted)
        )

        if lowerCased {
            hourAsString = hourAsString.lowercased(with: .current)
        }

        if !spaceBetweenHourAndAmPm {
            hourAsString = hourAsString.filter { !$0.isWhitespace }
        }

        return hourAsString
    }
}
