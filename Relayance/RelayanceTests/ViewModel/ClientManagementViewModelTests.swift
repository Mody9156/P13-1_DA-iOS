//
//  ClientManagementViewModelTests.swift
//  RelayanceTests
//
//  Created by KEITA on 12/11/2024.
//

import XCTest
@testable import Relayance
final class ClientManagementViewModelTests: XCTestCase {

    
    func testWhenAddNewClient_DoesNotThrowError() async throws{
        //Given
        let dateNow = Date.now
        let client = Client(nom: "James", email: "JamesBrown@gmail.com", dateCreationString: "2022-03-10T10:45:00Z")
        let viewModel = ClientManagementViewModel(client: client )
        
        //When
        let newClient = try await viewModel.addClientToList(nom: "James", email:"JamesBrown@gmail.com")
        //Then
        XCTAssertEqual(newClient[0].nom, "James")
        XCTAssertEqual(newClient[0].email, "JamesBrown@gmail.com")
        
    }
    
    func testWhenEmailIsInvalid(){
        
    }
    

}
