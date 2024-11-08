//
//  ClientTests.swift
//  RelayanceTests
//
//  Created by KEITA on 07/11/2024.
//

import XCTest
@testable import Relayance

final class ClientTests: XCTestCase {
   
   
    func testCreerNouveauClient_CreationReussie(){
        //Given
        let nom = "Nelson"
        let email = "Nelson_exemple@gmail.com"
        let dateCreationString = "2023-11-07T12:00:00Z"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                
        //When
        let creerNouveauClient = Client.creerNouveauClient(nom: nom, email: email)
        
        //Then
        XCTAssertEqual(creerNouveauClient.nom, nom)
        XCTAssertEqual(creerNouveauClient.email, email)
        
        let currentDataString = dateFormatter.string(from: Date())
        XCTAssertEqual(creerNouveauClient.dateCreationString.prefix(19), currentDataString.prefix(19))
    }
    
    func testCreerNouveauClient_WhenInvalidData_ShouldReturnFailure(){
        //Given
        let nom = ""
        let email = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                
        //When
        let creerNouveauClient = Client.creerNouveauClient(nom: nom, email: email)
        //Then
        XCTAssertTrue(creerNouveauClient.nom.isEmpty)
        XCTAssertTrue(creerNouveauClient.email.isEmpty)
        
    }
    
    func testGivenNewClient_WhenRegistered_ThenClientIsRegistered(){
        //Given
        let nom = ""
        let email = ""
        let dateCreationString = "2023-11-07T12:00:00Z"
        let creerNouveauClient = Client(nom: nom, email: email, dateCreationString: dateCreationString)
        let toDay = Date.now

        //when
        let estNouveauClient = creerNouveauClient.estNouveauClient()
        
        //then
        XCTAssertEqual(estNouveauClient,false)
        XCTAssertEqual(toDay.getDay(), creerNouveauClient.dateCreation.getDay())
        XCTAssertEqual(toDay.getMonth(), creerNouveauClient.dateCreation.getMonth())
        XCTAssertEqual(toDay.getYear(), creerNouveauClient.dateCreation.getYear())

    }
}
