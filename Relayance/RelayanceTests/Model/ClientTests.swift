//
//  ClientTests.swift
//  RelayanceTests
//
//  Created by KEITA on 07/11/2024.
//

import XCTest
@testable import Relayance

final class ClientTests: XCTestCase {
    
    func testClientInitialization_WithValidData_ContainsExpectedClients(){
        
        var nom  = "Malala Yousafzai"
        var email = "malala.yousafzai@example.com"
        var dateCreationString = "2022-03-10T10:45:00Z"
        var dateCreation: Date {
            Date.dateFromString(dateCreationString) ?? Date.now
        }

        let client = Client(nom: nom, email: email, dateCreationString: dateCreationString)
        
        XCTAssertEqual(client.nom, nom)
        XCTAssertEqual(client.email, email)
        XCTAssertEqual(client.dateCreation, dateCreation)
       
    }


}
