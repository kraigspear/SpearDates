//
//  DateExtensionTest.swift
//  SpearDates
//
//  Created by Kraig Spear on 4/22/25.
//

import Foundation
import Testing
@testable import SpearDates

@Test
func testDateSubtractionOperator() {
    // Arrange
    // Create two dates with a known difference
    let date1 = Date.atGiven(month: 5, day: 15, year: 2025, hour: 10, minute: 30, second: 45)
    #expect(date1 != nil, "Failed to create first test date")
    
    let date2 = Date.atGiven(month: 3, day: 10, year: 2024, hour: 8, minute: 15, second: 30)
    #expect(date2 != nil, "Failed to create second test date")
    
    // Act
    // Subtract the earlier date from the later date
    let difference = date1! - date2!
    
    // Assert
    // Verify all components of the difference
    #expect(difference.month == 2)
    #expect(difference.day == 5)
    #expect(difference.year == 1)
    #expect(difference.hour == 2)
    #expect(difference.minute == 15)
    #expect(difference.second == 15)
    
    // Test with same date (should be all zeros)
    let zeroDifference = date1! - date1!
    #expect(zeroDifference.month == 0)
    #expect(zeroDifference.day == 0)
    #expect(zeroDifference.year == 0)
    #expect(zeroDifference.hour == 0)
    #expect(zeroDifference.minute == 0)
    #expect(zeroDifference.second == 0)
}
