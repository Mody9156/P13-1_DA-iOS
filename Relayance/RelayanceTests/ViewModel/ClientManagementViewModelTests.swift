//
//  ClientManagementViewModelTests.swift
//  RelayanceTests
//
//  Created by KEITA on 12/11/2024.
//

import XCTest
@testable import Relayance
import SwiftUI
import Foundation

final class ClientManagementViewModelTests: XCTestCase {
    
    var clientManagementViewModel : ClientManagementViewModel!
    var initialNom : String!
    var initialEmail : String!
    
    override func setUp() {
        super.setUp()
        self.clientManagementViewModel  = ClientManagementViewModel(client: Client.stubClientWithEmptyData())
        self.initialNom  = "John Doe"
        self.initialEmail = "john.doe@example.com"
    }
   
    func testWhenAddNewClient_doesNotThrowError() throws{
        //Given
        let initialClient = Client(nom: initialNom, email: initialEmail, dateCreationString: "2024-10-10T08:30:00.000Z")
        clientManagementViewModel.clientsList = [initialClient]
        
        let nom = "Bruce"
        let email = "JamesBrown_Step3@gmail.com"
        
        //When
        let updatedClientsList = try clientManagementViewModel.addClientToList(nom: nom, email:email)
        
        //Then
        XCTAssertEqual(updatedClientsList.count, 2)
        XCTAssertEqual(updatedClientsList[1].nom,nom)
        XCTAssertEqual(updatedClientsList[1].email,email)
        XCTAssertEqual(clientManagementViewModel.message, "Nouveau client ajouté avec succès.")

    }
    
    func testShouldReturnErrorWhenEmailIsInvalid() throws {
        //Given
        let initialClient = Client(nom: initialNom, email: initialEmail, dateCreationString: "2024-10-10T08:30:00.000Z")
        clientManagementViewModel.clientsList = [initialClient]

        let nom = "Bruce"
        let email = "JamesBrown_Step"
        
        //When
        let updatedClientsList = try clientManagementViewModel.addClientToList(nom: nom, email:email)

        //Then
        XCTAssertEqual(updatedClientsList.count, 1)
        XCTAssertEqual(clientManagementViewModel.message,"Adresse email invalide. Veuillez vérifier et réessayer.")
    }
    
    func testShouldPassValidationWhenEmailIsValid() throws {
        //Given
        let initialClient = Client(nom: initialNom, email: initialEmail, dateCreationString: "2024-10-10T08:30:00.000Z")
        clientManagementViewModel.clientsList = [initialClient]

        let nom = "Bruce"
        let email = "JamesBrown_Step@gmail.com"
        
        //When
        let updatedClientsList = try clientManagementViewModel.addClientToList(nom: nom, email:email)

        //Then
        XCTAssertEqual(updatedClientsList.count, 2)
        XCTAssertNoThrow(updatedClientsList[1].email)
        XCTAssertEqual(updatedClientsList[1].email,email)
        
    }
    
    
    func testShouldReturnErrorWhenAddingExistingClient() throws {
        //Given
        let initialClient = Client(nom: initialNom, email: initialEmail, dateCreationString: "2024-10-10T08:30:00.000Z")
        clientManagementViewModel.clientsList = [initialClient]

        let nom = "John Doe"
        let email = "john.doe@example.com"
                
        //When
        let _ = try clientManagementViewModel.addClientToList(nom: nom, email:email)
        let _ = clientManagementViewModel.clientExiste(nom: nom, email: email)

        //Then
        XCTAssertEqual(clientManagementViewModel.clientsList.count, 1)
        XCTAssertEqual(clientManagementViewModel.message, "Ce client existe déjà dans la liste.")
      

    }

    func testDeleteClientDoesNotThrowError() throws {
        //Given
        let initialClient = Client(nom: initialNom, email: initialEmail, dateCreationString: "2024-10-10T08:30:00.000Z")
        clientManagementViewModel.clientsList = [initialClient]

        //When
        let removeClientFromList: () = try clientManagementViewModel.removeClientFromList(nom: initialNom, email:initialEmail)

        //Then
        XCTAssertNoThrow(removeClientFromList)
        XCTAssertTrue(clientManagementViewModel.clientsList.isEmpty)
 
    }
    
    func testWhenDeleteClient_ThrowError() throws {
        //Given
        let initialClient = Client(nom: initialNom, email: initialEmail, dateCreationString: "2024-10-10T08:30:00.000Z")
        clientManagementViewModel.clientsList = [initialClient]
        
        let nom = ""
        let email = ""
                
        //When
        let _ = try clientManagementViewModel.addClientToList(nom: nom, email:email)
        

        //Then
        XCTAssertThrowsError(try clientManagementViewModel.removeClientFromList(nom: nom, email:email))
        XCTAssertTrue(clientManagementViewModel.clientsList.count == 1)
 
    }
    
     func testShouldCreateNewClient_WhenDataIsValid(){
         //Given
         let nom = "Nelson"
         let email = "Nelson_exemple@gmail.com"
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                 
         //When
         let createNouveauClient = ClientManagementViewModel.createNouveauClient(nom: nom, email: email)
         
         //Then
         XCTAssertEqual(createNouveauClient.nom, nom)
         XCTAssertEqual(createNouveauClient.email, email)
         
         let currentDataString = dateFormatter.string(from: Date())
         XCTAssertEqual(createNouveauClient.dateCreationString.prefix(19), currentDataString.prefix(19))
     }
     
     func testShouldCreateNouveauClient_WhenCreationIsSuccessful(){
         //Given
         let nom = ""
         let email = ""
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                 
         //When
         let createNouveauClient = ClientManagementViewModel.createNouveauClient(nom: nom, email: email)
         
         //Then
         XCTAssertTrue(createNouveauClient.nom.isEmpty)
         XCTAssertTrue(createNouveauClient.email.isEmpty)
         
     }
     
     func testGivenDateIsToday_WhenGetDateIsSame_ReturnsTrue(){
         //Given
         let nom = "James"
         let email = "Rodrigue@gmail.com"
         let testHelpers = TestHelpers()
         let createdDateWithToDay = testHelpers.createdDateWithToDay()
         let dateCreationString = createdDateWithToDay
         let client = Client(nom: nom, email: email, dateCreationString: dateCreationString)
         let clientManagementViewModel =  ClientManagementViewModel(client: client)
         let toDay = Date.now
         
         //when
         let estNouveauClient = clientManagementViewModel.estNouveauClient()
        
         //then
         XCTAssertEqual(estNouveauClient,true)
     }
     
     func testGivenDateIsNotToday_WhenGetDateIsDifferent_ReturnsFalse(){
         //Given
         let nom = "James"
         let email = "Rodrigue@gmail.com"
         let dateCreationString = "2023-01-07T16:02:42.000Z"
         let client = Client(nom: nom, email: email, dateCreationString: dateCreationString)
         let clientManagementViewModel = ClientManagementViewModel(client: client)
         let toDay = Date.now
         
         //when
         let estNouveauClient = clientManagementViewModel.estNouveauClient()
         
         //then
         XCTAssertEqual(estNouveauClient,false)
     }
  
     func testClientExists_WhenClientDoesNotExist_ShouldReturnFalse(){
         //Given
         let nom = "Cena John"
         let email = "www_Cena.John@catch.com"
         let dateCreationString = "2024-10-07T12:00:00.000Z"
         let client = Client(nom: nom, email: email, dateCreationString: dateCreationString)
         let list = [
                 Client(nom: "Alice Dupont", email: "alice.dupont@example.com", dateCreationString: "2023-11-07T12:00:00.000Z"),
                 Client(nom: "Bob Martin", email: "bob.martin@example.com", dateCreationString: "2023-12-01T10:00:00.000Z"),
                 Client(nom: "Charlie Brown", email: "charlie.brown@example.com", dateCreationString: "2023-10-15T15:00:00.000Z")
             ]
         let clientManagementViewModel =  ClientManagementViewModel(client: client)

         //When
         let clientExiste = clientManagementViewModel.clientExiste(nom: nom, email: email)
         
         //Then
         XCTAssertEqual(clientExiste, false)
         
     }
     
     
     func testDateFormattedToString_WhenValidDate_ShouldReturnCorrectString(){
         //Given
         let nom = "Cena John"
         let email = "www_Cena.John@catch.com"
         let dateCreationString = "2024-10-07T12:00:00.000Z"
         let client = Client(nom: nom, email: email, dateCreationString: dateCreationString)
         let clientManagementViewModel =  ClientManagementViewModel(client: client)

         //when
         let dateFormat = clientManagementViewModel.formatDateVersString()
         //then
         XCTAssertNotNil(dateFormat)
     
         //When
         let type = type(of: dateFormat) == String.self
         
         //Then
         XCTAssertTrue(type)

     }
   
     func testDateFormattedToString_WhenInvalidDate_ShouldReturnCorrectString(){
         //Given
         let nom = "Cena John"
         let email = "www_Cena.John@catch.com"
         let dateCreationString = "2024-10-07T12:00:00.000Z"
         let client = Client(nom: nom, email: email, dateCreationString: dateCreationString)
         let clientManagementViewModel =  ClientManagementViewModel(client: client)

         var validDateFormat = clientManagementViewModel.formatDateVersString()
         validDateFormat = dateCreationString
         print("validDateFormat:\(validDateFormat)")
         
         XCTAssertEqual(validDateFormat, client.dateCreationString)
     }
     
     func testDateCreation_WhenDateCreationStringIsInvalid_ShouldReturnCurrentDate(){
         //Given
         let nom = "Cena John"
         let email = "www_Cena.John@catch.com"
         let dateCreationString = ""
         let client = Client(nom: nom, email: email, dateCreationString: dateCreationString)

         //When
         let type = client.dateCreation
         let dateNow = Date.now
         
         //Then
         XCTAssert(abs(type.timeIntervalSince(dateNow)) < 1)
        
     }
}


