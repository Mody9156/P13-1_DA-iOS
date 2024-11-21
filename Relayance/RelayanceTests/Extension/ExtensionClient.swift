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
          return Client(nom: "", email: "", dateCreationString: "")
      }
      
      static func stubClientWithInvalidEmail() -> Client {
          return Client(nom: "Jane Doe", email: "invalid-email", dateCreationString: "2023-11-07T12:00:00Z")
      }
}

extension ModelData {
    
    static func mockChargementFileNotFound<T: Decodable>(_ nomFichier: String) -> T {
        fatalError("Impossible de trouver \(nomFichier) dans le main bundle.")
    }
}
