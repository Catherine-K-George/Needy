//
//  HomeServiceTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 07/02/24.
//

import XCTest
@testable import NeedyShoppingApp

final class HomeServiceTests: XCTestCase {
    
    var mockNetworkManager = MockNetworkManager()
    var serviceConfiguration = ServiceConfiguration(endpoint: NetworkConstants.Endpoints.login)
    var homeService: HomeService?
    
    override func setUp() {
        super.setUp()
        homeService = HomeService(networkManager: mockNetworkManager, serviceConfiguration: serviceConfiguration)
    }
    
    func testLoginCreateURLSuccess() {
        let categoryURL = mockNetworkManager.constructURL(endpoint: NetworkConstants.Endpoints.categories, parameters: [:])
        XCTAssertNotNil(categoryURL)
        XCTAssertTrue(categoryURL?.absoluteString == NetworkConstants.Endpoints.categories)
    }
    
    func testLoginCreateURLFail() {
        let categoryURL = mockNetworkManager.constructURL(endpoint: "", parameters: [:])
        XCTAssertNil(categoryURL)
    }
    
    func testCategoryFetchSuccess() {
        let expectedCategories = ["testCategory1", "testCategory2"]
        
        let categoryData = try? JSONEncoder().encode(expectedCategories)
        mockNetworkManager.mockedData = categoryData
        let expectation = self.expectation(description: "Category fetch success")
        homeService?.fetchCategories(completion: { result in
            if case .success(let response) = result {
                XCTAssertEqual(response, expectedCategories)
                expectation.fulfill()
            }
        })

        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testLoginFailure() {
        let expectedError = NetworkError.invalidURL
        mockNetworkManager.mockedError = expectedError

        let expectation = self.expectation(description: "Category fetch fail")
        homeService?.fetchCategories(completion: { result in
            if case .failure(let error) = result {
                XCTAssertTrue(error is NetworkError)
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGuardFailureInvalidURL() {
        let serviceConfiguration = ServiceConfiguration(endpoint: "")
        let expectation = XCTestExpectation(description: "Invalid URL completion called")
        
        let homeService = HomeService(networkManager: mockNetworkManager, serviceConfiguration: serviceConfiguration)
        
        homeService.fetchCategories(completion: { result in
            if case .failure(let error) = result {
                XCTAssertTrue(error is NetworkError)
                expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 1.0)
    }

}
