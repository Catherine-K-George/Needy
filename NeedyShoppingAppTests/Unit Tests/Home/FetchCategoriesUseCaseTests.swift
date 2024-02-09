//
//  FetchCategoriesUseCaseTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 15/01/24.
//

import XCTest
@testable import NeedyShoppingApp

final class FetchCategoriesUseCaseTests: XCTestCase {
    var useCase: FetchCategoriesUseCase!
    var mockRepository: MockCategoriesRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockCategoriesRepository()
        useCase = FetchCategoriesUseCase(repository: mockRepository)
    }
    
    func testFetchCategoriesSuccess() {
        // Given
        let expectedCategories = ["Category1", "Category2"]
        mockRepository.mockedResult = .success(expectedCategories)
        
        // When
        var resultCategories: [String]?
        let expectation = self.expectation(description: "Fetch categories success")
        useCase.fetchCategories { result in
            if case .success(let categories) = result {
                resultCategories = categories
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(resultCategories, expectedCategories)
    }
    
    func testFetchCategoriesFailure() {
        let expectedError = NetworkError.invalidURL
        mockRepository.mockedResult = .failure(expectedError)
        
        var resultError: Error?
        let expectation = self.expectation(description: "Fetch categories failure")
        useCase.fetchCategories { result in
            if case .failure(let error) = result {
                resultError = error
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(resultError)
        XCTAssertTrue(resultError is NetworkError)
    }

    func testNoFetchCategoriesResult() {
        mockRepository.mockedResult = nil
        var resultError: Error?
        let expectation = self.expectation(description: "Fetch categories failure")
        useCase.fetchCategories { result in
            if case .failure(let error) = result {
                resultError = error
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(resultError)
        XCTAssertTrue(resultError is NetworkError)
    }
}
