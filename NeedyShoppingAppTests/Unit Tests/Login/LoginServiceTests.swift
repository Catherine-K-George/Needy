//
//  LoginServiceTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 06/02/24.
//

import XCTest
@testable import NeedyShoppingApp

final class LoginServiceTests: XCTestCase {
    
    var mockNetworkManager = MockNetworkManager()
    var serviceConfiguration = ServiceConfiguration(endpoint: NetworkConstants.Endpoints.login)
    var loginService: LoginService?
    
    override func setUp() {
        super.setUp()
        loginService = LoginService(networkManager: mockNetworkManager, serviceConfiguration: serviceConfiguration)
    }
    
    func testLoginCreateURLSuccess() {
        let loginURL = mockNetworkManager.constructURL(endpoint: NetworkConstants.Endpoints.login, parameters: [:])
        XCTAssertNotNil(loginURL)
        XCTAssertTrue(loginURL?.absoluteString == NetworkConstants.Endpoints.login)
    }
    
    func testLoginCreateURLFail() {
        let loginURL = mockNetworkManager.constructURL(endpoint: "", parameters: [:])
        XCTAssertNil(loginURL)
    }
    
    func testLoginSuccess() {
        let username = "testUser"
        let password = "testPassword"
        let expectedToken = "mockToken"
        let expectation = self.expectation(description: "Login success")
        mockNetworkManager.mockedData = try? JSONEncoder().encode(LoginResponse(token: expectedToken))

        let request = NeedyShoppingApp.LoginRequest(username: username, password: password)
        loginService?.login(request: request) { result in
            if case .success(let response) = result {
                XCTAssertEqual(response.token, expectedToken)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testLoginFailure() {
        let username = "testUser"
        let password = "testPassword"
        let expectedError = NetworkError.invalidURL
        mockNetworkManager.mockedError = expectedError

        let expectation = self.expectation(description: "Login should fail")
        let request = NeedyShoppingApp.LoginRequest(username: username, password: password)

        loginService?.login(request: request) { result in
            if case .failure(let error) = result {
                XCTAssertTrue(error is NetworkError)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGuardFailureInvalidURL() {
        let serviceConfiguration = ServiceConfiguration(endpoint: "")
        let request = NeedyShoppingApp.LoginRequest(username: "testUser", password: "testPassword")
        let expectation = XCTestExpectation(description: "Invalid URL completion called")
        
        let loginService = LoginService(networkManager: mockNetworkManager, serviceConfiguration: serviceConfiguration)
        
        loginService.login(request: request) { result in
            if case .failure(let error) = result {
                XCTAssertTrue(error is NetworkError)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }

}
