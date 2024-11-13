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
    func testWhenAddNewClient_DoesNotThrowError() async throws{
        //Given
        let initialNom = "John Doe"
        let initialEmail = "john.doe@example.com"
        let initialClient = Client(nom: initialNom, email: initialEmail, dateCreationString: "2024-10-10T08:30:00.000Z")
        let clientManagementViewModel = ClientManagementViewModel(client: Client(nom: "", email: "", dateCreationString: ""))
        clientManagementViewModel.clientsList = [initialClient] // Assurez-vous que la liste est initialisée

        let nom = "Bruce"
        let email = "JamesBrown_Step3@gmail.com"
        
        //When
        let updatedClientsList = try clientManagementViewModel.addClientToList(nom: nom, email:email)
        //Then
        XCTAssertEqual(updatedClientsList.count, 2)
        XCTAssertEqual(updatedClientsList[1].nom,nom)
        XCTAssertEqual(updatedClientsList[1].email,email)

    }
    
//    func testWhenEmailIsInvalid() throws {
//        //Given
//        let nom = "Bruce"
//        let email = "JamesBrown_Step3gmail.com"
//
//        //When
//        let updatedClientsList = try clientManagementViewModel.addClientToList(nom: nom, email:email)
//
//        //Then
//        XCTAssertEqual(updatedClientsList.count, 1)
//    }
//
//
//    func testWhenDeleteClient() throws {
//        //Given
//        let nom = "Bruce"
//        let email = "JamesBrown_Step3gmail.com"
//
//        //When
//        let removeClientFromList = try clientManagementViewModel.removeClientFromList(nom: nom, email:email)
//
//        //Then
//        XCTAssertNil(removeClientFromList)
//        XCTAssertNoThrow(removeClientFromList)
//
//    }
    
}


