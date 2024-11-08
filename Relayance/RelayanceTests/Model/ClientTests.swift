//
//  ClientTests.swift
//  RelayanceTests
//
//  Created by KEITA on 07/11/2024.
//

import XCTest
@testable import Relayance

final class ClientTests: XCTestCase {
   
//
//    func testClientInitialization_WithValidData_ContainsExpectedClients(){
//        //Given
//        let nom  = "John Doe"
//        let email = "john.doe@example.com"
//        let dateCreationString = "2023-11-07T12:00:00Z"
//        var dateCreation: Date {
//            Date.dateFromString(dateCreationString) ?? Date.now
//        }
//
//        //When
//        let stub = Client.stubClient()
//
//        //Then
//        XCTAssertEqual(stub.nom, nom)
//        XCTAssertEqual(stub.email, email)
//        XCTAssertEqual(stub.dateCreation, dateCreation)
//    }//à revoir
//
//    func testClientInitialization_WithInValidData_ContainsExpectedClients(){
//
//        let client = Client.stubClientWithEmptyData()
//
//        //Then
//        XCTAssertTrue(client.nom.isEmpty)
//        XCTAssertTrue(client.email.isEmpty)
//        XCTAssertNotNil(client.dateCreation)
//    }//à revoir
    
    func testAddNewClient_WithValidData_AddsClientSuccessfully(){
        
        //Given
        let newName = "Jane Doe"
        let newEmail = "john.doe@example.com"
        
        //When
        let stubClient = StubClient.creerNouveauClient(nom: newName, email: newEmail)
        
        XCTAssertEqual(stubClient.nom, newName)
        XCTAssertEqual(stubClient.email, newEmail)
         
    }
    
    func testAddNewClient_WithValidData_AddsClientFailure(){
        
        //Given
        let newName = ""
        let newEmail = ""
        
        //When
        let stubClient = StubClient.creerNouveauClient(nom: newName, email: newEmail)

        //Then
        XCTAssertTrue(stubClient.nom.isEmpty)
        XCTAssertTrue(stubClient.email.isEmpty)
    }
    
    func testClientStatus_WhenNotNew_ClientIsNotNew(){
        //Given
        let newName = "Malala Yousafzai"
        let newEmail = "malala.yousafzai@example.com"
        let dateCreationString = "2022-03-10T10:45:00Z"
        let date = Date.now
        let client =  Client(nom: newName, email: newEmail, dateCreationString: dateCreationString)
        let estNouveauClient = client.estNouveauClient()

        //When
        XCTAssertEqual(estNouveauClient,false)
        XCTAssertNotEqual(date.getYear(), client.dateCreation.getYear())
        XCTAssertNotEqual(date.getDay(), client.dateCreation.getDay())
        XCTAssertNotEqual(date.getMonth(), client.dateCreation.getMonth())
    }
    
    func testClientInitialization_WhenNew_ClientIsMarkedAsNew(){
        //Given
        let nom  = "Jack Wick"
        let email = "Jack.Wick_2@example.com"
        let dateCreationString = "2024-02-10T10:25:00Z"
        var dateCreation: Date {
            Date.dateFromString(dateCreationString) ?? Date.now
        }
        //When
        let client = Client(nom: nom, email: email, dateCreationString: dateCreationString)
        
        let estNouveauClient = client.estNouveauClient()
        
        XCTAssertTrue(estNouveauClient)
    }
    
}
