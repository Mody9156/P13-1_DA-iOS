//
//  TestHelpers.swift
//  RelayanceTests
//
//  Created by KEITA on 13/11/2024.
//

import Foundation
import Relayance
   
    func createdDateWithToDay() -> String {
        let calendar  = Calendar.current
        let now = Date()
        
        let composants = calendar.dateComponents([.year,.month,.day], from: now)
        
        let newDate = calendar.date(from: composants)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateString = dateFormatter.string(from: newDate)
        
        return dateString
    }
