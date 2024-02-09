//
//  LoginUseCaseTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 15/01/24.
//

import XCTest
@testable import NeedyShoppingApp

final class LoginUseCaseTests: XCTestCase {
    
    var loginUseCase: LoginUseCase!
    var mockRepository: MockLoginRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockLoginRepository()
        loginUseCase = LoginUseCase(repository: mockRepository)
    }
    
    func testLoginSuccess() {
        // Given
        let username = "testUser"
        let password = "testPassword"
        let expectedToken = "mockToken"
        mockRepository.mockedResult = .success(LoginResponseDomainModel(token: expectedToken))
        
        // When
        let request = LoginRequestDomainModel(username: username, password: password)
        loginUseCase.login(request) { result in
            if case .success(let response) = result {
                XCTAssertEqual(response.token, expectedToken)
            }
        }
    }
    
    func testLoginFailure() {
        // Given
        let username = "testUser"
        let password = "testPassword"
        let expectedError = NetworkError.invalidURL
        mockRepository.mockedResult = .failure(expectedError)
        let request = LoginRequestDomainModel(username: username, password: password)

        loginUseCase.login(request) { result in
            if case .failure(let error) = result {
                XCTAssertTrue(error is NetworkError)
            }
        }
    }
    
    func testNoLoginResult() {
        mockRepository.mockedResult = nil
        let username = "testUser"
        let password = "testPassword"
        let request = LoginRequestDomainModel(username: username, password: password)

        loginUseCase.login(request) { result in
            if case .failure(let error) = result {
                XCTAssertTrue(error is NetworkError)
            }
        }
    }
}
