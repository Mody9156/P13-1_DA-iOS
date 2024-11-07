//
//  DateExtension.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import Foundation

extension Date {
    static func dateFromString(_ isoString: String) -> Date? {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate]
        
        return isoDateFormatter.date(from: isoString)
    }//7
    
    static func stringFromDate(_ date: Date) -> String? {
        let isoDateFormatter = DateFormatter()
        isoDateFormatter.dateFormat = "dd-MM-yyyy"
        
        return isoDateFormatter.string(from: date)
    }//8
    
    func getDay() -> Int {
        return Calendar.current.component(.day, from: self)
    }//9
    
    func getMonth() -> Int {
        return Calendar.current.component(.month, from: self)
    }//10
    
    func getYear() -> Int {
        return Calendar.current.component(.year, from: self)
    }//11
    
}
