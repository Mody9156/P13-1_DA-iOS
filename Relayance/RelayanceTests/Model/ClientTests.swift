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
    
    func testClientInitialization_WithInValidData_ContainsExpectedClients(){
        //Given
        let nom  = ""
        let email = ""
        let dateCreationString = ""
        //When
        let client = Client(nom: nom, email: email, dateCreationString: dateCreationString)
        
        //Then
        XCTAssertTrue(client.nom.isEmpty)
        XCTAssertTrue(client.email.isEmpty)
        XCTAssertNotNil(client.dateCreation)
    }
    
    func testAddNewClient_WithValidData_AddsClientSuccessfully(){
        
        //Given
        let newName = "FakeName"
        let newEmail = "exemple@gmail.com"
        
        //When
        let creerNouveauClient = Client.creerNouveauClient(nom: newName, email: newEmail)
        
        //Then
        XCTAssertEqual(creerNouveauClient.nom, newName)
        XCTAssertEqual(creerNouveauClient.email, newEmail)
         
    }
    
    func testAddNewClient_WithValidData_AddsClientFailure(){
        
        //Given
        let newName = ""
        let newEmail = ""
        
        //When
        let creerNouveauClient = Client.creerNouveauClient(nom: newName, email: newEmail)
        
        //Then
        XCTAssertTrue(creerNouveauClient.nom.isEmpty)
        XCTAssertTrue(creerNouveauClient.email.isEmpty)
        XCTAssertNotNil(creerNouveauClient.formatDateVersString())
    }
    
    func testClientStatus_WhenNotNew_ClientIsNotNew(){
        //Given
        let nom  = "Malala Yousafzai"
        let email = "malala.yousafzai@example.com"
        let dateCreationString = "2022-03-10T10:45:00Z"
        var dateCreation: Date {
            Date.dateFromString(dateCreationString) ?? Date.now
        }
        //When
        let client = Client(nom: nom, email: email, dateCreationString: dateCreationString)
        
        let estNouveauClient = client.estNouveauClient()
        
        XCTAssertFalse(estNouveauClient)
    }
    
    func testClientInitialization_WhenNew_ClientIsMarkedAsNew(){
        //Given
        let nom  = "Jordan J.Mick"
        let email = "Jordan.Mick_1@example.com"
        let dateCreationString = "2023-06-10T10:35:00Z"
        var dateCreation: Date {
            Date.dateFromString(dateCreationString) ?? Date.now
        }
        //When
        let client = Client(nom: nom, email: email, dateCreationString: dateCreationString)
        
        let estNouveauClient = client.estNouveauClient()
        
        XCTAssertTrue(estNouveauClient)
    }
    
}
