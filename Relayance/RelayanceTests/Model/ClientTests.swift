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
        
        //Given
        let nom  = "Malala Yousafzai"
        let email = "malala.yousafzai@example.com"
        let dateCreationString = "2022-03-10T10:45:00Z"
        var dateCreation: Date {
            Date.dateFromString(dateCreationString) ?? Date.now
        }
        //When
        let client = Client(nom: nom, email: email, dateCreationString: dateCreationString)
        
        //Then
        XCTAssertEqual(client.nom, nom)
        XCTAssertEqual(client.email, email)
        XCTAssertEqual(client.dateCreation, dateCreation)
       
    }
    
    


}
