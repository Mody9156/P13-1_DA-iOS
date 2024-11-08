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
        let nom  = "John Doe"
        let email = "john.doe@example.com"
        let dateCreationString = "2023-11-07T12:00:00Z"
        var dateCreation: Date {
            Date.dateFromString(dateCreationString) ?? Date.now
        }

        //When
        let stub = Client.stubClient()

        //Then
        XCTAssertEqual(stub.nom, nom)
        XCTAssertEqual(stub.email, email)
        XCTAssertEqual(stub.dateCreation, dateCreation)
    }
    
    func testClientInitialization_WithInValidData_ContainsExpectedClients(){
        
        let client = Client.stubClientWithEmptyData()
        
        //Then
        XCTAssertTrue(client.nom.isEmpty)
        XCTAssertTrue(client.email.isEmpty)
        XCTAssertNotNil(client.dateCreation)
    }
    
    func testAddNewClient_WithValidData_AddsClientSuccessfully(){
        
        //Given
        let newName = "Jane Doe"
        let newEmail = "john.doe@example.com"
        let newDateCreationString = "2023-11-07T12:00:00.000Z"
        
        //When
        let client =  Client.stubCreatedNewClient()
        
        XCTAssertEqual(client.nom, newName)
        XCTAssertEqual(client.email, newEmail)
         
    }
    
    func testAddNewClient_WithValidData_AddsClientFailure(){
        
        //Given
        let newName = ""
        let newEmail = ""
        
        //When
//        let clientStub =  ClientStub.creerNouveauClient(nom: newName, email: newEmail)

        //Then
//        XCTAssertTrue(clientStub.nom.isEmpty)
//        XCTAssertTrue(clientStub.email.isEmpty)
//        XCTAssertNotNil(clientStub.formatDateVersString())
    }
    
    func testClientStatus_WhenNotNew_ClientIsNotNew(){
        //Given
        let nom  = "Malala Yousafzai"
        let email = "malala.yousafzai@example.com"
        let dateCreationString = "2022-03-10T10:45:00Z"
        var dateCreation: Date {
            Date.dateFromString(dateCreationString) ?? Date.now
        }
        let aujourdhui = Date.now
        
        //When
        let client = Client(nom: nom, email: email, dateCreationString: dateCreationString)

        let estNouveauClient = client.estNouveauClient()
        
        XCTAssertFalse(estNouveauClient)
        XCTAssertNotEqual(aujourdhui.getYear(), client.dateCreation.getYear())
        XCTAssertNotEqual(aujourdhui.getMonth(), client.dateCreation.getMonth())
        XCTAssertNotEqual(aujourdhui.getDay(), client.dateCreation.getDay())

    }
    
//    func testClientInitialization_WhenNew_ClientIsMarkedAsNew(){
//        //Given
//        let nom  = "Jordan J.Mick"
//        let email = "Jordan.Mick_1@example.com"
//        let dateCreationString = "2023-06-10T10:35:00Z"
//        var dateCreation: Date {
//            Date.dateFromString(dateCreationString) ?? Date.now
//        }
//        //When
//        let client = Client(nom: nom, email: email, dateCreationString: dateCreationString)
//        
//        let estNouveauClient = client.estNouveauClient()
//        
//        XCTAssertTrue(estNouveauClient)
//    }
    
}
