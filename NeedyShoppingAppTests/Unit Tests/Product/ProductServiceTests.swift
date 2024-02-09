//
//  ProductServiceTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 06/02/24.
//

import XCTest
@testable import NeedyShoppingApp

final class ProductServiceTests: XCTestCase {
    var productService: ProductService?
    var mockNetworkManager = MockNetworkManager()
    var serviceConfiguration = ServiceConfiguration(endpoint: NetworkConstants.Endpoints.login)

    func testInvalidURLFetchCategory() {
        let category = "electronics"
        let expectedError = NetworkError.invalidURL
        mockNetworkManager.mockedError = expectedError
        productService = ProductService(networkManager: mockNetworkManager, serviceConfiguration: serviceConfiguration)
        var resultError: Error?
        var resultProducts: [ProductModel]?
        let expectation = self.expectation(description: "Fetch product failure")
        productService?.fetchProducts(category: category) { result in
            if case .failure(let error) = result {
                resultError = error
                XCTAssertTrue(error is NetworkError)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(resultProducts)
        XCTAssertNotNil(resultError)
        
    }

    func testFetchProductsSuccess() {
        let category = "electronics"
        let product1 = ProductModel(id: 9, title: "WD 2TB Elements Portable External Hard Drive - USB 3.0 ", price: 64.0, category: "electronics", description: "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system", image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg")
        let product2 = ProductModel(id: 10, title: "WD 2TB Elements Portable External Hard Drive - USB 3.0 ", price: 64.0, category: "electronics", description: "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system", image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg")
        let expectedProducts = [product1, product2]
        
        let productData = try? JSONEncoder().encode(expectedProducts)
        mockNetworkManager.mockedData = productData
        productService = ProductService(networkManager: mockNetworkManager, serviceConfiguration: serviceConfiguration)
        productService?.fetchProducts(category: category) { result in
            if case .success(let products) = result {
                XCTAssertEqual(products.count, expectedProducts.count)
                XCTAssertEqual(products.first?.title, product1.title)
            }
        }
    }

    func testFetchProductsFailure() {
        let category = "electronics"
        let expectedError = NetworkError.invalidURL
        mockNetworkManager.mockedError = expectedError
        productService = ProductService(networkManager: mockNetworkManager, serviceConfiguration: serviceConfiguration)
        productService?.fetchProducts(category: category) { result in
            if case .failure(let error) = result {
                XCTAssertTrue(error is NetworkError)
            }
        }
    }
    
    func testGuardFailureInvalidURL() {
        let serviceConfiguration = ServiceConfiguration(endpoint: "")
        let expectation = XCTestExpectation(description: "Invalid URL completion called")
        
        let productService = ProductService(networkManager: mockNetworkManager, serviceConfiguration: serviceConfiguration)
        let mockCategory = "test"
        productService.fetchProducts(category: mockCategory) { result in
            if case .failure(let error) = result {
                XCTAssertTrue(error is NetworkError)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
}

