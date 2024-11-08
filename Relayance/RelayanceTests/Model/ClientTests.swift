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
        let creerNouveauClient = Client(nom: nom, email: email, dateCreationString: dateCreationString)
        let toDay = Date.now
        
        //when
        let estNouveauClient = creerNouveauClient.estNouveauClient()
        let test1 = toDay.getDay() != creerNouveauClient.dateCreation.getDay()
        let test2 = toDay.getMonth() != creerNouveauClient.dateCreation.getMonth()
        let test3 = toDay.getYear() != creerNouveauClient.dateCreation.getYear()

        //then
        XCTAssertEqual(estNouveauClient,true)
    }
    
    func testGivenDateIsNotToday_WhenGetDateIsDifferent_ReturnsFalse(){
        //Given
        let nom = "James"
        let email = "Rodrigue@gmail.com"
        let dateCreationString = "2023-01-07T16:02:42.000Z"
        let creerNouveauClient = Client(nom: nom, email: email, dateCreationString: dateCreationString)
        let toDay = Date.now
        
        //when
        let estNouveauClient = creerNouveauClient.estNouveauClient()
        let test1 = toDay.getDay() != creerNouveauClient.dateCreation.getDay()
        let test2 = toDay.getMonth() != creerNouveauClient.dateCreation.getMonth()
        let test3 = toDay.getYear() != creerNouveauClient.dateCreation.getYear()

        //then
        XCTAssertEqual(estNouveauClient,false)
    }
}
