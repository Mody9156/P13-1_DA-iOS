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
    
    override func setUp() {
        super.setUp()
              let client = Client(nom: "John Doe", email: "john.doe@example.com", dateCreationString: "2024-10-10T08:30:00.000Z")
        clientManagementViewModel = ClientManagementViewModel(client: client)
        clientManagementViewModel.clientsList = [client]
         }
    
    func testWhenAddNewClient_DoesNotThrowError() async throws{
        //Given
        let nom = "Bruce"
        let email = "JamesBrown_Step3@gmail.com"
        
        //When
        let updatedClientsList = try clientManagementViewModel.addClientToList(nom: nom, email:email)
 
        //Then
        XCTAssertEqual(updatedClientsList.count, 2, "Le client devrait être ajouté.")
        XCTAssertEqual(updatedClientsList[0].nom,"John Doe")
        XCTAssertEqual(updatedClientsList[0].email, "john.doe@example.com")
        XCTAssertEqual(updatedClientsList[1].nom,nom)
        XCTAssertEqual(updatedClientsList[1].email, email)
           
    }
    
    func testWhenEmailIsInvalid() throws {
        //Given
        let nom = "Bruce"
        let email = "JamesBrown_Step3gmail.com"
        
        //When
        let updatedClientsList = try clientManagementViewModel.addClientToList(nom: nom, email:email)
 
        //Then
        XCTAssertEqual(updatedClientsList.count, 1)
    }
   
    
    func testWhenDeleteClient() throws {
        //Given
        let nom = "Bruce"
        let email = "JamesBrown_Step3gmail.com"
        
        //When
        let removeClientFromList = try clientManagementViewModel.removeClientFromList(nom: nom, email:email)
        
        //Then
        XCTAssertTrue(removeClientFromList.email.isEmpty)
        XCTAssertTrue(removeClientFromList.nom.isEmpty)
        
    }
    
}


