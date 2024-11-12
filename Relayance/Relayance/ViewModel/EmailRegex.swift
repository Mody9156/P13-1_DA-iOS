//
//  EmailRegex.swift
//  Relayance
//
//  Created by KEITA on 12/11/2024.
//

import Foundation


enum EmailRegex{
    
    case email = .isValidEmail(<#T##String#>)
    
    func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPredicate.evaluate(with: email)
    }
        
}
