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
        let initialClient = Client(
            nom: initialNom,
            email: initialEmail,
            dateCreationString: "2024-10-10T08:30:00.000Z")
        
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
        let initialClient = Client.stubClientWithInvalidEmail()
        
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
        let initialClient = Client(
            nom: initialNom,
            email: initialEmail,
            dateCreationString: "2024-10-10T08:30:00.000Z")
        
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
        let initialClient = Client(
            nom: initialNom,
            email: initialEmail,
            dateCreationString: "2024-10-10T08:30:00.000Z")
        
        clientManagementViewModel.clientsList = [initialClient]
        
        let nom = "John Doe"
        let email = "john.doe@example.com"
        
        //When
        let _ = try clientManagementViewModel.addClientToList(nom: nom, email:email)
        let _ = clientManagementViewModel.doesClientExist(nom: nom, email: email)
        
        //Then
        XCTAssertEqual(clientManagementViewModel.clientsList.count, 1)
        XCTAssertEqual(clientManagementViewModel.message, "Ce client existe déjà dans la liste.")
    }
    
    func testDeleteClientDoesNotThrowError() throws {
        //Given
        let initialClient = Client(
            nom: initialNom,
            email: initialEmail,
            dateCreationString: "2024-10-10T08:30:00.000Z")
        
        clientManagementViewModel.clientsList = [initialClient]
        
        //When
        let removeClientFromList: () = try clientManagementViewModel.removeClientFromList(nom: initialNom, email:initialEmail)
        
        //Then
        XCTAssertNoThrow(removeClientFromList)
        XCTAssertTrue(clientManagementViewModel.clientsList.isEmpty)
    }
    
    func testWhenDeleteClient_throwError() throws {
        //Given
        let initialClient = Client(
            nom: initialNom,
            email: initialEmail,
            dateCreationString: "2024-10-10T08:30:00.000Z")
        
        clientManagementViewModel.clientsList = [initialClient]
        
        let nom = ""
        let email = ""
        
        //When
        let _ = try clientManagementViewModel.addClientToList(nom: nom, email:email)
        
        //Then
        XCTAssertThrowsError(try clientManagementViewModel.removeClientFromList(nom: nom, email:email))
        XCTAssertTrue(clientManagementViewModel.clientsList.count == 1)
    }
    
    func testShouldCreateNewClient_whenDataIsValid(){
        //Given
        let nom = "Nelson"
        let email = "Nelson_exemple@gmail.com"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        //When
        let createNouveauClient = ClientManagementViewModel.createNewClient(nom: nom, email: email)
        
        //Then
        XCTAssertEqual(createNouveauClient.nom, nom)
        XCTAssertEqual(createNouveauClient.email, email)
        
        let currentDataString = dateFormatter.string(from: Date())
        XCTAssertEqual(createNouveauClient.dateCreationString.prefix(19), currentDataString.prefix(19))
    }
    
    func testShouldCreateNouveauClient_whenCreationIsFailure(){
        //Given
        let nom = ""
        let email = ""
        
        //When
        let createNouveauClient = ClientManagementViewModel.createNewClient(nom: nom, email: email)
        
        //Then
        XCTAssertTrue(createNouveauClient.nom.isEmpty)
        XCTAssertTrue(createNouveauClient.email.isEmpty)
        
    }
    
    func testGivenDateIsToday_whenGetDateIsSame_returnsTrue() throws {
        //Given
        let client = Client.stubClient()
        clientManagementViewModel.clientsList = [client]
        
        let initialClient = Client(
            nom: initialNom,
            email: initialEmail,
            dateCreationString: "2024-10-10T08:30:00.000Z")
        
        clientManagementViewModel.clientsList = [initialClient]
        
        let nom = "Nelson"
        let email = "Nelson_exemple@gmail.com"
        
        //When
        try clientManagementViewModel.addClientToList(nom: nom, email:email)
        
        let isNewClient = clientManagementViewModel.isNewClient(client: clientManagementViewModel.clientsList[1])
        
        //then
        XCTAssertEqual(isNewClient,true)
    }
    
    func testGivenDateIsNotToday_whenGetDateIsDifferent_returnsFalse(){
        //Given
        let client = Client.stubClient()
        let clientManagementViewModel = ClientManagementViewModel(client: client)
        
        //when
        let isNewClient = clientManagementViewModel.isNewClient(client: client)
        
        //then
        XCTAssertEqual(isNewClient,false)
    }
    
    func testDateFromStringWithValidFormatReturnsCorrectDate(){
        //Given
        let date = "2023-02-20T09:15:00Z"
        
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate]
        
        //When
        let dateFromString  = Date.dateFromString(date)
        
        //Then
        XCTAssertEqual(dateFromString, isoDateFormatter.date(from: date))
    }
    
    func testDateFromStringWithInvalidFormatReturnsNil(){
        //Given
        let date = ""
        
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate]
        
        //When
        let dateFromString  = Date.dateFromString(date)
        
        //Then
        XCTAssertEqual(dateFromString, nil)
    }
    
    func testDateToString_whenValidDate_shouldReturnFormattedString(){
        //Given
        let date = "2023-02-20T09:15:00Z"
        
        let dateFromString = Date.dateFromString(date)
        
        //When
        let stringFromDate = Date.stringFromDate(dateFromString ?? Date.now)
        
        //Then
        XCTAssertEqual(stringFromDate, "20-02-2023")
        
    }
    
    func testDateToString_whenValidDate_shouldReturnCurrentDateAsString(){
        //Given
        let date = ""
        let isoDateFormatter = DateFormatter()
        isoDateFormatter.dateFormat = "dd-MM-yyyy"
        let dateNow = isoDateFormatter.string(from:Date.now)
        
        let dateFromString = Date.dateFromString(date)
        
        //When
        let stringFromDate = Date.stringFromDate(dateFromString ?? Date.now)
        
        //Then
        XCTAssertEqual(stringFromDate, dateNow)
        
    }
    
    func testDecodeJsonFile_doesNotThrowError() throws {
        //Given
          struct User : Codable,Equatable{
            var nom : String
            var email : String
            var date_creation : String
        }
        
        //When
        let modelData : [User] = ModelData.chargement("Source.json")
        print("Voici ton tableau : \(modelData)")
        
        //Then
        XCTAssertFalse(modelData.isEmpty)
        XCTAssertEqual(modelData[0].nom, "Frida Kahlo")
        XCTAssertEqual(modelData[1].email, "mahatma.gandhi@example.com")
        XCTAssertEqual(modelData[2].date_creation, "2022-03-10T10:45:00Z")

    }
    
    func testDecodeJsonFile_returnsEmptyArrayWhenNoData() throws {
        //Given
          struct User : Codable,Equatable{
            var nom : String
            var email : String
            var date_creation : String
        }
        
        //When
        let modelData : [User] = ModelData.chargement("")
        print("Voici ton tableau : \(modelData)")
        
        //Then
        XCTAssertTrue(modelData.isEmpty)
    }
    
    func testClientExists_whenClientDoesNotExist_shouldReturnFalse(){
        //Given
        let nom = "John Cena"
        let email = "www_Cena.John@catch.com"
        let list = [
            Client(
                nom: "Alice Dupont",
                email: "alice.dupont@example.com",
                dateCreationString: "2023-11-07T12:00:00.000Z"),
            Client(
                nom: "Bob Martin",
                email: "bob.martin@example.com",
                dateCreationString: "2023-12-01T10:00:00.000Z"),
            Client(
                nom: "Charlie Brown",
                email: "charlie.brown@example.com",
                dateCreationString: "2023-10-15T15:00:00.000Z")
        ]
        
        clientManagementViewModel.clientsList = list
        
        //When
        let clientExiste = clientManagementViewModel.doesClientExist(nom: nom, email: email)
        
        //Then
        XCTAssertEqual(clientExiste, false)
    }
    
    func testDateFormattedToString_whenValidDate_shouldReturnCorrectString(){
        //Given
        let client = Client.stubClient()
        clientManagementViewModel.clientsList = [client]
        let dateCreation = client.dateCreation
        let dateNow = Date.now
        //when
        let formatDateToString = clientManagementViewModel.formatDateToString(client: client)
        
        //then
        XCTAssertNotNil(formatDateToString)
        
        //When
        let type = type(of: formatDateToString) == String.self
        
        //Then
        XCTAssertTrue(type)
        XCTAssertEqual(formatDateToString, "07-11-2023")
        XCTAssertFalse(abs(dateCreation.timeIntervalSince(dateNow)) < 1)
    }
    
    func testDateFormattedToString_whenDateIsInvalid_returnsDateNow(){
        //Given
        let client = Client.stubClientWithEmptyData()
        let date = Date.stringFromDate(Date.now)
        let type = client.dateCreation
        let dateNow = Date.now
        //When
        let formatDateToString = clientManagementViewModel.formatDateToString(client: client)
        
        //Then
        XCTAssertEqual(formatDateToString, date)
        XCTAssert(abs(type.timeIntervalSince(dateNow)) < 1)

    }
}


