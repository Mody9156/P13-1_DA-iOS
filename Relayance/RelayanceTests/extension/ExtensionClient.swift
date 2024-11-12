//
//  ExtensionClient.swift
//  RelayanceTests
//
//  Created by KEITA on 12/11/2024.
//

import XCTest
@testable import Relayance

extension Client {
   
    static var clientTest: Client {
        return Client(nom: "", email: "", dateCreationString: "")
    }
    
    static var clientTest2: Client {
        return Client(nom: "Jane Doe", email: "jane.doe@example.com", dateCreationString: "2024-10-10T08:30:00.000Z")
    }
}

