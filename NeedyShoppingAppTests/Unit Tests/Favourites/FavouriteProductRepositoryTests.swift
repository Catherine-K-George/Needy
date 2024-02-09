//
//  FavouriteProductRepositoryTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 07/02/24.
//

import XCTest
@testable import NeedyShoppingApp

final class FavouriteProductRepositoryTests: XCTestCase {
    var favouriteProductRepository: FavouriteProductsRepository?
    var service = MockFavouriteProductsService()
    
    override func setUp() {
        super.setUp()
        favouriteProductRepository = FavouriteProductsRepository(service: service)
    }

    func testInvalidURLFetchCategory() {
        let expectedError = NetworkError.invalidURL
        var resultError: Error?
        var resultProducts: [ProductModel]?
        let expectation = self.expectation(description: "Fetch favourites failure")
        favouriteProductRepository?.fetchFavouriteProducts({ result in
            if case .failure(let error) = result {
                resultError = error
                XCTAssertTrue(error is NetworkError)
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(resultProducts)
        XCTAssertNotNil(resultError)
        
    }

    func testFetchProductsSuccess() {
        let product1 = ProductModel(id: 9, title: "WD 2TB Elements Portable External Hard Drive - USB 3.0 ", price: 64.0, category: "electronics", description: "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system", image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg")
        let product2 = ProductModel(id: 10, title: "WD 2TB Elements Portable External Hard Drive - USB 3.0 ", price: 64.0, category: "electronics", description: "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system", image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg")
        let expectedProducts = [product1, product2]
        
        favouriteProductRepository?.fetchFavouriteProducts({ result in
            if case .success(let products) = result {
                XCTAssertEqual(products.count, expectedProducts.count)
                XCTAssertEqual(products.first?.title, product1.title)
            }
        })
    }

    func testFetchProductsFailure() {

        favouriteProductRepository?.fetchFavouriteProducts({ result in
            if case .failure(let error) = result {
                XCTAssertTrue(error is NetworkError)
            }
        })
    }
}


final class FavouriteProductsServiceTests: XCTestCase {
    var favouriteProductsService: FavouriteProductsService?
    var mockNetworkManager = MockNetworkManager()

    func testInvalidURLFetchCategory() {
        let expectedError = NetworkError.invalidURL
        mockNetworkManager.mockedError = expectedError
        favouriteProductsService = FavouriteProductsService(networkManager: mockNetworkManager)
        var resultError: Error?
        var resultProducts: [ProductModel]?
        let expectation = self.expectation(description: "Fetch product failure")
        favouriteProductsService?.fetchFavouriteProducts({ result in
            if case .failure(let error) = result {
                resultError = error
                XCTAssertTrue(error is NetworkError)
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(resultProducts)
        XCTAssertNotNil(resultError)
        
    }

    func testFetchProductsSuccess() {
        let product1 = ProductModel(id: 9, title: "WD 2TB Elements Portable External Hard Drive - USB 3.0 ", price: 64.0, category: "electronics", description: "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system", image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg")
        let product2 = ProductModel(id: 10, title: "WD 2TB Elements Portable External Hard Drive - USB 3.0 ", price: 64.0, category: "electronics", description: "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system", image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg")
        let expectedProducts = [product1, product2]
        
        let productData = try? JSONEncoder().encode(expectedProducts)
        mockNetworkManager.mockedData = productData
        favouriteProductsService = FavouriteProductsService(networkManager: mockNetworkManager)
        favouriteProductsService?.fetchFavouriteProducts({ result in
            if case .success(let products) = result {
                XCTAssertEqual(products.count, expectedProducts.count)
                XCTAssertEqual(products.first?.title, product1.title)
            }
        })
    }

    func testFetchProductsFailure() {
        let expectedError = NetworkError.invalidURL
        mockNetworkManager.mockedError = expectedError
        favouriteProductsService = FavouriteProductsService(networkManager: mockNetworkManager)
        favouriteProductsService?.fetchFavouriteProducts({ result in
            if case .failure(let error) = result {
                XCTAssertTrue(error is NetworkError)
            }
        })
    }

}

