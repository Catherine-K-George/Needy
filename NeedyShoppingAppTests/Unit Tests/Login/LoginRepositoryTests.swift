//
//  LoginRepositoryTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 15/01/24.
//

import XCTest
@testable import NeedyShoppingApp

final class LoginRepositoryTests: XCTestCase {
    
    var mockService = MockLoginService()
    var loginRepository: LoginRepository?

    override func setUp() {
        super.setUp()
        loginRepository = LoginRepository(service: mockService)
    }

    func testLoginInvalidURL() {
        let username = "testUser"
        let password = "testPassword"
        loginRepository = LoginRepository(service: MockLoginService())
        let expectedError = NetworkError.invalidURL
        mockService.mockedResult = .failure(expectedError)
        
        let expectation = self.expectation(description: "Login should fail")
        let request = LoginRequestDomainModel(username: username, password: password)
        loginRepository?.login(request) { result in
            if case .failure(let error) = result {
                XCTAssertTrue(error is NetworkError)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testLoginSuccess() {
        let username = "testUser"
        let password = "testPassword"
        let expectedToken = "mockToken"
        let expectation = self.expectation(description: "Login success")
        mockService.mockedResult = .success(NeedyShoppingApp.LoginResponse(token: expectedToken))
        
        let request = LoginRequestDomainModel(username: username, password: password)
        loginRepository?.login(request) { result in
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
        mockService.mockedResult = .failure(expectedError)

        let expectation = self.expectation(description: "Login should fail")
        let request = LoginRequestDomainModel(username: username, password: password)

        loginRepository?.login(request) { result in
            if case .failure(let error) = result {
                XCTAssertTrue(error is NetworkError)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil) 
    }
    
    func testLoginDataMappingToDomainRequest() {
        let requestModel = NeedyShoppingApp.LoginRequest(username: "testUser", password: "testPassword")
        let domainModel = LoginDataModelMapper.mapToDomainRequestModel(from: requestModel)
        XCTAssertTrue(domainModel is LoginRequestDomainModel)
    }
    
    func testLoginDomainToDataResponseMapping() {
        let responseModel = LoginResponseDomainModel(token: "token")
        let dataResponseModel = LoginDataModelMapper.mapToDataResponseModel(from: responseModel)
        XCTAssert(dataResponseModel is NeedyShoppingApp.LoginResponse)
    }
    
    func testLoginDataMappingToDomainResponse() {
        let responseModel = NeedyShoppingApp.LoginResponse(token: "token")
        let domainResponse = LoginDataModelMapper.mapToDomainResponseModel(from: responseModel)
        XCTAssert(domainResponse is LoginResponseDomainModel)
    }
    
}

