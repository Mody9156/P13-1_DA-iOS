//
//  EmailRegexTests.swift
//  RelayanceTests
//
//  Created by KEITA on 18/11/2024.
//

import XCTest
@testable import Relayance

final class EmailRegexTests: XCTestCase {

   
    func testWhenEmailNoThrowsError()  {
        //given
        let email = "exemple@gmail.com"

        //When
        let emailRegex = EmailRegex.isValidEmail(email)
        
        //Then
        XCTAssertTrue(emailRegex)
    }

}
