//
//  HomeViewModelTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 10/01/24.
//

import XCTest
@testable import NeedyShoppingApp

class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var mockFetchCategoriesUseCase: MockFetchCategoriesUseCase!

    override func setUp() {
        super.setUp()
        mockFetchCategoriesUseCase = MockFetchCategoriesUseCase()
        viewModel = HomeViewModel(fetchCategoriesUseCase: mockFetchCategoriesUseCase)
    }

    func testFetchProductCategoriesSuccess() {
        let expectedCategories = ["Category1", "Category2"]
        mockFetchCategoriesUseCase.mockedResult = .success(expectedCategories)
        
        var resultCategories: [String]?
        var resultError: Error?
        let expectation = self.expectation(description: "Fetch product categories success")
        viewModel.fetchProductCategories { result in
            if case .success(let categories) = result {
                resultCategories = categories
            }
            expectation.fulfill()
            
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(resultCategories, expectedCategories)
        XCTAssertNil(resultError)
        XCTAssertEqual(viewModel.numberOfRows(), expectedCategories.count)
        XCTAssertEqual(viewModel.categoryTitle(for: IndexPath(row: 0, section: 0)), "Category1")
        
    }

    func testFetchProductCategoriesFailure() {
        let expectedError = NetworkError.invalidURL
        mockFetchCategoriesUseCase.mockedResult = .failure(expectedError)
        
        var resultCategories: [String]?
        var resultError: Error?
        let expectation = self.expectation(description: "Fetch product categories failure")
        viewModel.fetchProductCategories { result in
            if case .failure(let error) = result {
                resultError = error
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(resultCategories)
        XCTAssertNotNil(resultError)
        XCTAssertEqual(viewModel.numberOfRows(), 0)
    }

    func testNoFetchCategoriesResult() {
        mockFetchCategoriesUseCase.mockedResult = nil
        var resultError: Error?
        let expectation = self.expectation(description: "Fetch categories failure")
        viewModel.fetchProductCategories { result in
            if case .failure(let error) = result {
                resultError = error
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(resultError)
        XCTAssertTrue(resultError is NetworkError)
    }
    
    func testRetrieveUsername() {
        let expectedUsername = "testUser"
        UserDefaults.standard.set(expectedUsername, forKey: StringConstants.UserDefaults.username)
        let retrievedUsername = viewModel.retrieveUsername()
        XCTAssertEqual(retrievedUsername, expectedUsername)
    }
    
    func testRetrieveUsernameFail() {
        UserDefaults.standard.removeObject(forKey: StringConstants.UserDefaults.username)
        let expectedUsername = ""
        let retrievedUsername = viewModel.retrieveUsername()
        XCTAssertEqual(retrievedUsername, expectedUsername)
    }
}
