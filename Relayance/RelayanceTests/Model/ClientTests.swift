//
//  ClientTests.swift
//  RelayanceTests
//
//  Created by KEITA on 07/11/2024.
//

import XCTest
@testable import Relayance

final class ClientTests: XCTestCase {
   
    func createdDateWithToDay() -> String {
        let calendar  = Calendar.current
        let now = Date()
        
        let composants = calendar.dateComponents([.year,.month,.day], from: now)
        
        let newDate = calendar.date(from: composants)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateString = dateFormatter.string(from: newDate)
         
        return dateString
    }
   
    func testCreerNouveauClient_CreationReussie(){
        //Given
        let nom = "Nelson"
        let email = "Nelson_exemple@gmail.com"        
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
    
    func testGivenDateIsToday_WhenGetDateIsSame_ReturnsTrue(){
        //Given
        let nom = "James"
        let email = "Rodrigue@gmail.com"
        let createdDateWithToDay = createdDateWithToDay()
        let dateCreationString = createdDateWithToDay
        let client = Client(nom: nom, email: email, dateCreationString: dateCreationString)
        let toDay = Date.now
        
        //when
        let estNouveauClient = client.estNouveauClient()
        let test1 = toDay.getDay() != client.dateCreation.getDay()
        let test2 = toDay.getMonth() != client.dateCreation.getMonth()
        let test3 = toDay.getYear() != client.dateCreation.getYear()

        //then
        XCTAssertEqual(estNouveauClient,true)
    }
    
    func testGivenDateIsNotToday_WhenGetDateIsDifferent_ReturnsFalse(){
        //Given
        let nom = "James"
        let email = "Rodrigue@gmail.com"
        let dateCreationString = "2023-01-07T16:02:42.000Z"
        let client = Client(nom: nom, email: email, dateCreationString: dateCreationString)
        let toDay = Date.now
        
        //when
        let estNouveauClient = client.estNouveauClient()
        let test1 = toDay.getDay() != client.dateCreation.getDay()
        let test2 = toDay.getMonth() != client.dateCreation.getMonth()
        let test3 = toDay.getYear() != client.dateCreation.getYear()

        //then
        XCTAssertEqual(estNouveauClient,false)
    }
    
    
    func testClientExists_WhenClientExists_ShouldReturnTrue(){
        //Given
        let nom = "James"
        let email = "Rodrigue@gmail.com"
        let dateCreationString = "2023-01-07T16:02:42.000Z"
        let client = Client(nom: nom, email: email, dateCreationString: dateCreationString)
        let list = [
                Client(nom: "Alice Dupont", email: "alice.dupont@example.com", dateCreationString: "2023-11-07T12:00:00.000Z"),
                Client(nom: "Bob Martin", email: "bob.martin@example.com", dateCreationString: "2023-12-01T10:00:00.000Z"),
                Client(nom: "Charlie Brown", email: "charlie.brown@example.com", dateCreationString: "2023-10-15T15:00:00.000Z")
            ]
        
        //When
        let clientExiste = client.clientExiste(clientsList: list)
        
        //Then
        XCTAssertEqual(clientExiste, true)
        
    }
}
