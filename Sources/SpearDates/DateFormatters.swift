import Foundation
import SpearFoundation

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
    ///   - hour: An integer representing the hour in 24-hour format (0-24). This parameter is clamped to ensure it falls within valid hour range.
    ///   - lowerCased: A Boolean value that determines whether the AM/PM designation should be lowercase. The default is `false`.
    ///   - spaceBetweenHourAndAmPm: A Boolean value that determines whether there should be a space between the hour and the AM/PM designation. The default is `true`.
    ///
    /// - Returns: A formatted string representing the hour with AM/PM designation.
    ///
    /// - Example:
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
