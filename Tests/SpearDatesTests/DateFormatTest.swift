//
//  DateFormatTest.swift
//  SpearDates
//
//  Created by Kraig Spear on 8/6/24.
//

import Foundation
@testable import SpearDates
import Testing

struct FormatTest {
    @Test("Zulu formatting")
    func zulu() {
        let dateComponents = DateComponents(
            timeZone: TimeZone(secondsFromGMT: 0),
            year: 2024,
            month: 8,
            day: 6,
            hour: 14,
            minute: 30,
            second: 0
        )

        let calendar = Calendar(identifier: .gregorian)
        let date = calendar.date(from: dateComponents)!

        let formatted = DateFormatters.formatZulu(date)
        #expect(formatted == "2024-08-06T14:30:00Z")
    }

    struct HourString {
        @Test("Short Hour")
        func shortHour() {
            #expect(DateFormatters.formatHourAmPm(2) == "2 AM")
            #expect(DateFormatters.formatHourAmPm(12) == "12 PM")
            #expect(DateFormatters.formatHourAmPm(17) == "5 PM")
        }

        @Test("No Spaces")
        func noSpaces() {
            #expect(DateFormatters.formatHourAmPm(2, spaceBetweenHourAndAmPm: false) == "2AM")
        }

        @Test("Lower cased")
        func lowerCased() {
            #expect(DateFormatters.formatHourAmPm(2, lowerCased: true) == "2 am")
        }

        @Test("Lower cased and no spaces")
        func lowerCasedNoSpaces() {
            #expect(DateFormatters.formatHourAmPm(
                2,
                lowerCased: true,
                spaceBetweenHourAndAmPm: false
            ) == "2am"
            )
        }
    }
}
