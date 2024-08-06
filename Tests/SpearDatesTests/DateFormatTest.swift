//
//  DateFormatTest.swift
//  SpearDates
//
//  Created by Kraig Spear on 8/6/24.
//

import Foundation
import Testing
@testable import SpearDates

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
        #expect("2024-08-06T14:30:00Z" == formatted)
        
    }
    
}
