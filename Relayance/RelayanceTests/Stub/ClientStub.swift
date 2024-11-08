//
//  ClientStub.swift
//  RelayanceTests
//
//  Created by KEITA on 07/11/2024.
//
import Foundation
import SwiftUI
import XCTest
@testable import Relayance


extension Client {
    
    static func stubClient() -> Client {
          return Client(nom: "John Doe", email: "john.doe@example.com", dateCreationString: "2023-11-07T12:00:00Z")
      }
      
      static func stubClientWithEmptyData() -> Client {
          return Client(nom: "", email: "", dateCreationString: "2023-11-07T12:00:00Z")
      }
      
      static func stubClientWithInvalidEmail() -> Client {
          return Client(nom: "Jane Doe", email: "invalid-email", dateCreationString: "2023-11-07T12:00:00Z")
      }
    
    static func stubCreatedNewClient() -> Client {
              
        let fixedDateString = "2023-11-07T12:00:00.000Z"

        return Client(nom: "Jane Doe", email: "john.doe@example.com", dateCreationString: fixedDateString)
        
    }
}


final class StubClient : ProtoMethode {
    
    var featureOneEnabled = false
    var email : String
    var nom : String
    var dateCreationString : String
    
    var dateCreation: Date {
        Date.dateFromString(dateCreationString) ?? Date.now
    }
    
    init(nom: String, email: String, dateCreationString: String) {
           self.nom = nom
           self.email = email
           self.dateCreationString = dateCreationString
       }
    
    static func creerNouveauClient(nom: String, email: String) -> Client {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let dateCreationString = dateFormatter.string(from: Date.now)
            
        return Client(nom: nom, email: email, dateCreationString: dateCreationString)
    }
    
    func estNouveauClient() -> Bool {
        let aujourdhui = Date.now
        let dateCreation = self.dateCreation
        
        return aujourdhui.getYear() == dateCreation.getYear() &&
                      aujourdhui.getMonth() == dateCreation.getMonth() &&
                      aujourdhui.getDay() == dateCreation.getDay()
    }
    
    func clientExiste(clientsList: [Relayance.Client]) -> Bool {
        return clientsList.contains { $0.email == self.email }
    }
    
    
}
