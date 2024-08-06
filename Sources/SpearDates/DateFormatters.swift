import Foundation

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

public struct DateFormatters {
    
    private init() {}
    
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
    
    public func formatZuluWithMilliseconds(_ date: Date) -> String {
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
    
    public func formatDayOfWeek(_ date: Date) -> String {
        date.formatted(.dateTime.weekday(.wide))
    }
    
    public func formatShortTime(_ date: Date) -> String {
        date.formatted(.dateTime.hour().minute())
    }
    
    public func formatShortDateTime(_ date: Date) -> String {
        date.formatted(
            .dateTime
                .year()
                .month()
                .day()
                .hour()
                .minute()
        )
    }
}
