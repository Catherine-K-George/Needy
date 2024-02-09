//
//  CategoriesRepositoryTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 15/01/24.
//

import XCTest
@testable import NeedyShoppingApp

final class CategoriesRepositoryTests: XCTestCase {
    var repository: CategoriesRepository?
    var mockService = MockHomeService()

    override func setUp() {
        super.setUp()
    }
    
    func testInvalidURLFetchCategory() {
        let expectedError = NetworkError.invalidURL
        mockService.mockedResult = .failure(expectedError)
        repository = CategoriesRepository(service: mockService)
        var resultError: Error?
        let expectation = self.expectation(description: "Fetch categories failure")
        repository?.fetchCategories { result in
            if case .failure(let error) = result {
                resultError = error
                XCTAssertTrue(error is NetworkError)
                XCTAssertNotNil(resultError)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchCategoriesSuccess() {
        let expectedCategories = ["testCategory"]
        mockService.mockedResult = .success(expectedCategories)
        repository = CategoriesRepository(service: mockService)
        var resultCategories: [String]?
        let expectation = self.expectation(description: "Fetch categories success")
        repository?.fetchCategories { result in
            if case .success(let categories) = result {
                resultCategories = categories
                XCTAssertEqual(resultCategories, expectedCategories)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchCategoriesFailure() {
        let expectedError = NetworkError.invalidURL
        mockService.mockedResult = .failure(expectedError)
        repository = CategoriesRepository(service: mockService)
        var resultError: Error?
        let expectation = self.expectation(description: "Fetch categories failure")
        repository?.fetchCategories { result in
            if case .failure(let error) = result {
                resultError = error
                XCTAssertNotNil(resultError)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
