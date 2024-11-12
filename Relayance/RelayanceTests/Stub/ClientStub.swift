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
    
    var mockClientsList: [Client]
        
        init(mockClientsList: [Client] = []) {
            self.mockClientsList = mockClientsList
        }
    
    
    func estNouveauClient() -> Bool {
        true
    }
    
    func clientExiste(clientsList: [Client]) -> Bool {
        return clientsList.contains { $0.nom == "Jane Doe" && $0.email == "jane.doe@example.com" }

    }
    
    func addClientToList(nom: String, email: String) throws -> [Client] {
        let newClient = Client(nom: nom, email: email, dateCreationString: "2024-11-11T10:00:00.000Z")
               
               if !mockClientsList.contains(where: { $0.nom == newClient.nom && $0.email == newClient.email }) {
                   if EmailRegex.isValidEmail(email) {
                       mockClientsList.append(newClient)  // Ajoute le client à la liste simulée
                   } else {
                       throw NSError(domain: "InvalidEmail", code: 400, userInfo: [NSLocalizedDescriptionKey: "Email invalide."])
                   }
               }
               return mockClientsList
    }
    
    func formatDateVersString() -> String {
        return "2024-11-11T10:00:00.000Z"

    }

}
