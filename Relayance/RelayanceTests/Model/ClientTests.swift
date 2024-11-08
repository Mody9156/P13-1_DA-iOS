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
        let stubClient = StubClient.creerNouveauClient(nom: nom, email: email)
        
        //Then
        XCTAssertEqual(stubClient.nom, nom)
        XCTAssertEqual(stubClient.email, email)
        
        let currentDataString = dateFormatter.string(from: Date())
        XCTAssertEqual(stubClient.dateCreationString.prefix(19), currentDataString.prefix(19))
    }
    
    func testCreerNouveauClient_WhenInvalidData_ShouldReturnFailure(){
        //Given
        let nom = ""
        let email = ""
        let dateCreationString = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                
        //When
        let stubClient = StubClient.creerNouveauClient(nom: nom, email: email)

        //Then
        XCTAssertTrue(stubClient.nom.isEmpty)
        XCTAssertTrue(stubClient.email.isEmpty)
        
    }
}
