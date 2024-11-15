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
        XCTAssertTrue(clientManagementViewModel.message.isEmpty)

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
     
     func testShouldCreateNouveauClient_WhenCreationIsFailure(){
         //Given
         let nom = ""
         let email = ""
         
         //When
         let createNouveauClient = ClientManagementViewModel.createNouveauClient(nom: nom, email: email)
         
         //Then
         XCTAssertTrue(createNouveauClient.nom.isEmpty)
         XCTAssertTrue(createNouveauClient.email.isEmpty)
         
     }

    func testGivenDateIsToday_whenGetDateIsSame_returnsTrue() throws {
         //Given
         let client = Client.stubClient()
         clientManagementViewModel.clientsList = [client]
        
        let initialClient = Client(nom: initialNom, email: initialEmail, dateCreationString: "2024-10-10T08:30:00.000Z")
        clientManagementViewModel.clientsList = [initialClient]
        
        let nom = "Nelson"
        let email = "Nelson_exemple@gmail.com"
                
        //When
        let addClient = try clientManagementViewModel.addClientToList(nom: nom, email:email)
        
        let estNouveauClient = clientManagementViewModel.estNouveauClient(client: clientManagementViewModel.clientsList[1])
        
         //then
         XCTAssertEqual(estNouveauClient,true)
     }
     
     func testGivenDateIsNotToday_whenGetDateIsDifferent_ReturnsFalse(){
         //Given
         let client = Client.stubClient()
         let clientManagementViewModel = ClientManagementViewModel(client: client)
         
         //when
         let estNouveauClient = clientManagementViewModel.estNouveauClient(client: client)
         
         //then
         XCTAssertEqual(estNouveauClient,false)
     }
  
     func testClientExists_WhenClientDoesNotExist_ShouldReturnFalse(){
         //Given
         let nom = "Cena John"
         let email = "www_Cena.John@catch.com"
         let list = [
                 Client(nom: "Alice Dupont", email: "alice.dupont@example.com", dateCreationString: "2023-11-07T12:00:00.000Z"),
                 Client(nom: "Bob Martin", email: "bob.martin@example.com", dateCreationString: "2023-12-01T10:00:00.000Z"),
                 Client(nom: "Charlie Brown", email: "charlie.brown@example.com", dateCreationString: "2023-10-15T15:00:00.000Z")
             ]
         
         clientManagementViewModel.clientsList = list

         //When
         let clientExiste = clientManagementViewModel.clientExiste(nom: nom, email: email)
         
         //Then
         XCTAssertEqual(clientExiste, false)
         
     }
     
     func testDateFormattedToString_WhenValidDate_ShouldReturnCorrectString(){
         //Given
         let client = Client.stubClient()
         clientManagementViewModel.clientsList = [client]

         //when
         let dateFormat = clientManagementViewModel.formatDateVersString(client: client)
         //then
         XCTAssertNotNil(dateFormat)
     
         //When
         let type = type(of: dateFormat) == String.self
         
         //Then
         XCTAssertTrue(type)

     }
   
     func testDateFormattedToString_whenInvalidDate_shouldReturnCorrectString(){
         //Given
         let dateCreationString = ""
         let client = Client(nom: initialNom, email: initialEmail, dateCreationString: dateCreationString)
         clientMgitanagementViewModel.clientsList = [client]
         let date = Date()
          let fomattingString = Date.stringFromDate(date)
          //then
          XCTAssertNotNil(fomattingString)
         //When
         let formatDateVersString = clientManagementViewModel.formatDateVersString(client: client)
         let isoDateFormatter = DateFormatter()
         isoDateFormatter.dateFormat = "dd-MM-yyyy"
         isoDateFormatter.string(from: client.dateCreation)
         //then
         XCTAssertEqual(formatDateVersString, fomattingString)
     }//a revoir
     
     func testDateCreation_whenDateCreationStringIsInvalid_shouldReturnCurrentDate(){
         //Given
         let dateCreationString = ""
         let client = Client(nom: initialNom, email: initialEmail, dateCreationString: dateCreationString)
         clientManagementViewModel.clientsList = [client]
         
         //When
         let type = client.dateCreation
         let dateNow = Date.now
         
         //Then
         XCTAssert(abs(type.timeIntervalSince(dateNow)) < 1)
        
     }
}


