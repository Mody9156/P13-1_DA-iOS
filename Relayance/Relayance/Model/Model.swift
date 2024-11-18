//
//  Model.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import Foundation

struct Client: Codable, Hashable {
    var nom: String
    var email: String
    var dateCreationString: String
    var dateCreation: Date {
        Date.dateFromString(dateCreationString) ?? Date.now
    }
    
    enum CodingKeys: String, CodingKey {
        case nom
        case email
        case dateCreationString = "date_creation"
    }
}
