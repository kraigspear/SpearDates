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
        let j = date.toJullianDayNumber()
        XCTAssertEqual(expected, j)
    }

    func testAddDays() {
        let oct172015 = Date(timeIntervalSince1970: 1_445_077_917)
        let aDayLater = oct172015.addDays(1)
        let mdy = aDayLater.toMonthDayYear()
        XCTAssertEqual(18, mdy.day)
    }
    
    func testAddMinutes() {
        //Saturday, October 17, 2015 10:31:57 AM
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
}
