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

    
    func testWhenAddNewClient_DoesNotThrowError() async throws{
        //Given
        
        let viewModel = ClientManagementViewModel(client: Client.clientTest2 )
        let addClient = viewModel.clientsList

        //When
        let newClient = try viewModel.addClientToList(nom: "James", email:"JamesBrown@gmail.com")
 
        //Then
        XCTAssertFalse(newClient.isEmpty)
        XCTAssertEqual(newClient.count, 1)
        
    }
    
    func testWhenEmailIsInvalid(){
        
    }
    
   
   
}


extension Client {
   
    static var clientTest: Client {
        return Client(nom: "", email: "", dateCreationString: "")
    }
    
    static var clientTest2: Client {
        return Client(nom: "Jane Doe", email: "jane.doe@example.com", dateCreationString: "2024-10-10T08:30:00.000Z")
    }
}
