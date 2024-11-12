//
//  ClientManagementViewModelTests.swift
//  RelayanceTests
//
//  Created by KEITA on 12/11/2024.
//

import XCTest
@testable import Relayance
final class ClientManagementViewModelTests: XCTestCase {

    
    func testWhenAddNewClient() async throws{
        let dateNow = Date.now
        let client = Client(nom: "James", email: "JamesBrown@gmail.com", dateCreationString: "2022-03-10T10:45:00Z")
        let viewModel = ClientManagementViewModel(client: client )
        
    }

}
