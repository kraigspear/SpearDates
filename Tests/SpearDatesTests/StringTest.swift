//
//  StringTest.swift
//  
//
//  Created by Kraig Spear on 7/8/20.
//

@testable import SpearDates
import XCTest

final class StringTest: XCTestCase {

    func testToDateFromZulu() {
        
        let date = "2017-12-14T13:05:56.796Z".toDateFromZulu()
        XCTAssertNotNil(date)
        
    }
    
    func testDateIsNilWhenNotAValidZuluDate() {
        
        let date = "2017-12-14T13:05:56.796Zwhoops".toDateFromZulu()
        XCTAssertNil(date)
        
    }
    
}
