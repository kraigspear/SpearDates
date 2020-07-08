//
//  StringExtensions.swift
//  
//
//  Created by Kraig Spear on 7/8/20.
//

import Foundation

extension String {
    
    /// Converts this string to date if it is a valid zulu date (2017-12-14T13:05:56.796Z)
    public func toDateFromZulu() -> Date? {
        for formatter in DateFormatters.instance.zulu {
            if let date = formatter.date(from: self) {
                return date
            }
        }

        return nil
    }
    
}
