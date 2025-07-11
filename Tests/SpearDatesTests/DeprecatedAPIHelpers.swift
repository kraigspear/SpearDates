//
//  DeprecatedAPIHelpers.swift
//  SpearDatesTests
//
//  Helper functions to wrap deprecated APIs for testing purposes.
//  This allows us to test deprecated functionality without warnings.
//

import SpearDates
import Foundation

// These functions wrap the deprecated APIs to suppress warnings in tests
// They are marked with @available to suppress the deprecation warnings

@available(*, deprecated)
internal extension Date {
    func testAddDays(_ numberOfDays: Int) -> Date {
        self.addDays(numberOfDays)
    }
    
    func testAddMinutes(_ numberOfMinutes: Int) -> Date {
        self.addMinutes(numberOfMinutes)
    }
    
    func testAddHours(_ numberOfHours: Int) -> Date {
        self.addHours(numberOfHours)
    }
    
    func testIsSameDay(_ date: Date) -> Bool {
        self.isSameDay(date)
    }
    
    func testNumberOfMinutesBetween(_ otherDate: Date) -> Int {
        self.numberOfMinutesBetween(otherDate)
    }
    
    func testNumberOfMinutesBetweenNow() -> Int {
        self.numberOfMinutesBetweenNow()
    }
    
    var testFirstHourOfDay: Date {
        self.firstHourOfDay
    }
    
    var testEpoch: TimeInterval {
        self.epoch
    }
    
    static func testFromMonth(_ month: Int, day: Int, year: Int) -> Date? {
        Date.fromMonth(month, day: day, year: year)
    }
}