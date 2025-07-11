//
//  DateTest.swift
//  SpearSwiftLib
//
//  Created by Kraig Spear on 12/29/15.
//  Copyright © 2015 spearware. All rights reserved.
//

@testable import SpearDates
import XCTest

final class DateTest: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testMDY() {
        let date = Date(timeIntervalSince1970: 1_445_077_917)

        let mdy = date.toMonthDayYear()

        XCTAssertEqual(10, mdy.month)
        XCTAssertEqual(17, mdy.day)
        XCTAssertEqual(2015, mdy.year)
    }

    func testMDYHMS() {
        let date = Date(timeIntervalSince1970: 1_445_077_917)

        let mdy = date.toMonthDayYearHourMinutesSeconds()

        XCTAssertEqual(10, mdy.month)
        XCTAssertEqual(17, mdy.day)
        XCTAssertEqual(2015, mdy.year)
        XCTAssertEqual(6, mdy.hour)
        XCTAssertEqual(31, mdy.minutes)
        XCTAssertEqual(57, mdy.seconds)
    }

    func testJulianDay() {
        let expected = Double(2_457_313.6)
        let date = Date(timeIntervalSince1970: 1_445_077_917)
        let j = date.toJulianDayNumber()
        XCTAssertEqual(expected, j)
    }

    func testAddDays() {
        let oct172015 = Date(timeIntervalSince1970: 1_445_077_917)
        let aDayLater = oct172015.addDays(1)
        let mdy = aDayLater.toMonthDayYear()
        XCTAssertEqual(18, mdy.day)
    }

    func testAddMinutes() {
        // Saturday, October 17, 2015 10:31:57 AM
        let oct172015 = Date(timeIntervalSince1970: 1_445_077_917)
        let twentyMinutesFrom = oct172015.addMinutes(20)
        let components = Calendar.current.dateComponents([Calendar.Component.minute], from: twentyMinutesFrom)
        // 31 + 20
        XCTAssertEqual(51, components.minute!)
    }

    func testIsSameDay() {
        let oct172015 = Date(timeIntervalSince1970: 1_445_077_917)
        let laterThatSameDay = Date(timeIntervalSince1970: 1_445_114_196)
        XCTAssertTrue(oct172015.isSameDay(laterThatSameDay))
    }

    func testIsSameDayAtOrAfter() {
        let expectedHour = 9
        let currentDate = Date(timeIntervalSince1970: 1_445_077_917)
        let dateAtNineAM = Calendar.current.date(
            bySettingHour: expectedHour,
            minute: 0,
            second: 0,
            of: currentDate
        )!

        XCTAssertTrue(
            dateAtNineAM.isSameDay(currentDate, hourAtOrAfter: expectedHour)
        )
    }

    func testIsBetween() {
        let oct172015At1031 = Date(timeIntervalSince1970: 1_445_077_917)
        let oct172015At1600 = Date(timeIntervalSince1970: 1_445_097_600)
        let oct172015At2036 = Date(timeIntervalSince1970: 1_445_114_196)

        XCTAssertTrue(oct172015At1600.isBetween(oct172015At1031, and: oct172015At2036))
    }

    func testIsNotBetween() {
        let oct172015At1031 = Date(timeIntervalSince1970: 1_445_077_917)
        let someDateIn2020 = Date(timeIntervalSince1970: 1_590_227_875)
        let oct172015At2036 = Date(timeIntervalSince1970: 1_445_114_196)

        XCTAssertFalse(someDateIn2020.isBetween(oct172015At1031, and: oct172015At2036))
    }

    func testNumberOfMinutesBetween() {
        let minutes = 20

        let date = Date(timeIntervalSince1970: 1_590_228_486)
        let twentyMinutesFromNow = date.addMinutes(minutes)

        XCTAssertEqual(minutes, twentyMinutesFromNow.numberOfMinutesBetween(date))
    }

    func testNumberOfDaysBetween() {
        let days = 7

        let date = Date(timeIntervalSince1970: 1_684_488_182)

        let sevenDaysFromNow = date.addDays(7)

        XCTAssertEqual(days, sevenDaysFromNow.numberOfDaysBetween(date))
    }

    func testNumberOfMinutesInDay() {
        let expect = 12 * 60
        let date = Date(timeIntervalSince1970: 1_640_365_200)
        XCTAssertEqual(expect, date.minuteOfDay)
    }

    func testNoonIsFiftyPrecentOfTheDay() {
        let date = Date(timeIntervalSince1970: 1_640_365_200)
        XCTAssertEqual(0.5, date.percentOfDay)
    }

    func testAtGivenValidHourMinute() {
        let date = Date(timeIntervalSince1970: 1_640_600_037)
        let expectedDate = Date(timeIntervalSince1970: 1_640_611_452)
        let atEightTwentyFour = date.atGiven(hour: 8, minute: 24, second: 12)
        XCTAssertNotNil(atEightTwentyFour)
        XCTAssertEqual(expectedDate, atEightTwentyFour)
    }

    func testPercentOfDayMidDay() {
        let pct = 0.5
        let date = Date(percentOfDay: pct)
        let components = date.toMonthDayYearHourMinutesSeconds()
        XCTAssertEqual(12, components.hour)
        XCTAssertEqual(0, components.minutes)
    }

    func testPercentOfDayEndOfDay() {
        let pct = 0.9999
        let date = Date(percentOfDay: pct)
        let components = date.toMonthDayYearHourMinutesSeconds()
        XCTAssertEqual(23, components.hour)
        XCTAssertEqual(59, components.minutes)
    }

    func testReplaceDate() {
        let someDate = Date(timeIntervalSince1970: 1_582_063_862)
        let todayMonthDayYear = Date().toMonthDayYear()
        let replaced = someDate.replacingDay().toMonthDayYear()

        XCTAssertEqual(todayMonthDayYear.month, replaced.month)
        XCTAssertEqual(todayMonthDayYear.day, replaced.day)
        XCTAssertEqual(todayMonthDayYear.year, replaced.year)
    }

    // MARK: - atGivenDate

    func testAtGivenWithValidDate() {
        let date = Date.atGiven(month: 9, day: 20, year: 2024, hour: 14, minute: 30, second: 45)
        XCTAssertNotNil(date, "Date should be created successfully")

        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date!)

        XCTAssertEqual(components.year, 2024)
        XCTAssertEqual(components.month, 9)
        XCTAssertEqual(components.day, 20)
        XCTAssertEqual(components.hour, 14)
        XCTAssertEqual(components.minute, 30)
        XCTAssertEqual(components.second, 45)
    }

    func testAtGivenWithDefaultTime() {
        let date = Date.atGiven(month: 3, day: 15, year: 2023)
        XCTAssertNotNil(date, "Date should be created successfully")

        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date!)

        XCTAssertEqual(components.year, 2023)
        XCTAssertEqual(components.month, 3)
        XCTAssertEqual(components.day, 15)
        XCTAssertEqual(components.hour, 0)
        XCTAssertEqual(components.minute, 0)
        XCTAssertEqual(components.second, 0)
    }

    func testAtGivenDateWithTime() {
        let date = Date.atGiven(
            month: 3,
            day: 15,
            year: 2023,
            hour: 8,
            minute: 30,
            second: 45
        )
        XCTAssertNotNil(date, "Date should be created successfully")
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date!)
        XCTAssertEqual(components.year, 2023)
        XCTAssertEqual(components.month, 3)
        XCTAssertEqual(components.day, 15)
        XCTAssertEqual(components.hour, 8)
        XCTAssertEqual(components.minute, 30)
        XCTAssertEqual(components.second, 45)
    }
}
