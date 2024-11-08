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
