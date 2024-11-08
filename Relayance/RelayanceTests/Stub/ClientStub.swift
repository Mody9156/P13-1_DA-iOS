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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                
        let fixedDateString = "2023-11-07T12:00:00.000Z"

        return Client(nom: "Jane Doe", email: "john.doe@example.com", dateCreationString: fixedDateString)
        
    }
}

class ClientStub : ProtoMethode {
    var nom : String
    var email : String
    

    
    init(nom: String, email: String) {
            self.nom = nom
            self.email = email
        }
    
    static func creerNouveauClient(nom: String, email: String) -> Relayance.Client {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateCreationString = dateFormatter.string(from: Date())

        return Relayance.Client(nom: nom, email: email, dateCreationString:dateCreationString)

    }
    
    func estNouveauClient() -> Bool {
        return nom.isEmpty || email.isEmpty

    }
    
    func clientExiste(clientsList: [Relayance.Client]) -> Bool {
        return clientsList.contains { $0.email == self.email }

    }
    
    func formatDateVersString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: Date())
    }
    
}

