//
//  LoginViewModelTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 10/01/24.
//

import XCTest
@testable import NeedyShoppingApp

class LoginViewModelTests: XCTestCase {
    var loginViewModel: LoginViewModel!
    var mockLoginUseCase: MockLoginUseCase!

    override func setUp() {
        super.setUp()
        mockLoginUseCase = MockLoginUseCase()
        loginViewModel = LoginViewModel(loginUseCase: mockLoginUseCase)
    }

    func testLoginSuccess() {
        let username = "testUser"
        let password = "testPassword"
        let expectedToken = "mockToken"
        mockLoginUseCase.mockedResult = .success(LoginResponseDomainModel(token: expectedToken))

        let expectation = self.expectation(description: "Login should succeed")

        loginViewModel.login(withUsername: username, password) { success in
            XCTAssertTrue(success)
            XCTAssertEqual(self.loginViewModel.token, expectedToken)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testLoginFailure() {
        let username = "testUser"
        let password = "testPassword"
        let expectedError = NetworkError.invalidURL
        mockLoginUseCase.mockedResult = .failure(expectedError)

        let expectation = self.expectation(description: "Login should fail")

        loginViewModel.login(withUsername: username, password) { success in
            XCTAssertFalse(success)
            XCTAssertNil(self.loginViewModel.token)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testNoLoginResult() {
        mockLoginUseCase.mockedResult = nil
        let username = "testUser"
        let password = "testPassword"
        loginViewModel.login(withUsername: username, password) { success in
            XCTAssertFalse(success)
        }
    }
}
