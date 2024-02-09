//
//  NetworkManagerTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 15/01/24.
//

import XCTest
@testable import NeedyShoppingApp

final class NetworkManagerTests: XCTestCase {
    
    var networkManager: NetworkManager!
    let session = MockURLSession()
    let datasource: RequestDataSource = .remoteURL(url: URL(string: "https://fakestoreapi.com/auth/login")!, method: .POST, body: nil)
    
    override func setUp() {
        super.setUp()
        networkManager = NetworkManager(urlSession: session)
    }
    
    func testFetchDataSuccess() {
        let mockData = """
                {
                    "token": "exampleValue"
                }
                """.data(using: .utf8)
        
        session.mockData = mockData
        let expectation = self.expectation(description: "Should return success")
        
        networkManager.fetchData(from: datasource, responseType: LoginResponse.self) { result in
            if case .success(let response) = result {
                XCTAssertEqual(response.token, "exampleValue")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchDataFailure() {
        let mockError = NetworkError.invalidURL
        session.mockError = mockError
        let expectation = self.expectation(description: "Should return failure")
        networkManager.fetchData(from: datasource, responseType: LoginResponse.self) { result in
            if case .failure(let error) = result {
                XCTAssertTrue(error is NetworkError)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testConstructURL() {
        let testURL = "https://fakestoreapi.com/auth/login"
        let url = NetworkManager().constructURL(endpoint: NetworkConstants.Endpoints.login)
        XCTAssertEqual(testURL, url?.absoluteString)
    }
    
    func testConstructURLWithQuery() {
        let testURL = "https://fakestoreapi.com/auth/login?name=test"
        let url = NetworkManager().constructURL(endpoint: NetworkConstants.Endpoints.login, parameters: ["name": "test"])
        XCTAssertEqual(testURL, url?.absoluteString)
    }
    
    func testProcessError() {
        let error = NetworkError.invalidURL
        networkManager.process(nil, nil, error) { (result: Result<LoginResponse, Error>) in
            if case .failure(let error) = result {
                XCTAssertTrue(error is NetworkError)
            }
        }
    }
    
    func testProcessSuccess() {
        let mockData = """
                {
                    "token": "exampleValue"
                }
                """.data(using: .utf8)
        let httpResponse = HTTPURLResponse(url: URL(string: "ttps://fakestoreapi.com/auth/login")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        networkManager.process(mockData, httpResponse, nil) { (result: Result<LoginResponse, Error>) in
            if case .success(let decodedResponse) = result {
                XCTAssertNotNil(decodedResponse)
            }
        }
    }
    
    func testProcessDataNil() {
        let httpResponse = HTTPURLResponse(url: URL(string: "ttps://fakestoreapi.com/auth/login")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        networkManager.process(nil, httpResponse, nil) { (result: Result<LoginResponse, Error>) in
            if case .failure(let error) = result {
                XCTAssertEqual((error as NSError).domain, "DataError")
            }
        }
    }
    
    func testProcessResponseNil() {
        let validData = Data()
        networkManager.process(validData, nil, nil) { (result: Result<LoginResponse, Error>) in
            if case .failure(let error) = result {
                XCTAssertEqual((error as NSError).domain, "HTTPError")
            }
        }
    }
    
    func testProcessDecodingError() {
        let mockData = """
                {
                    "test": "exampleValue"
                }
                """.data(using: .utf8)
        let httpResponse = HTTPURLResponse(url: URL(string: "ttps://fakestoreapi.com/auth/login")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        networkManager.process(mockData, httpResponse, nil) { (result: Result<LoginResponse, Error>) in
            if case .failure(let error) = result {
                XCTAssertEqual((error as NSError).domain, "NSCocoaErrorDomain")
            }
        }
    }
}
