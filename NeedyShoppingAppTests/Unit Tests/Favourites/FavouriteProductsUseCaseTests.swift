//
//  FavouriteProductsUseCaseTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 07/02/24.
//

import XCTest
@testable import NeedyShoppingApp

final class FavouriteProductsUseCaseTests: XCTestCase {
    var favouriteProductsUseCase: FavouriteProductsUseCase!
    var mockFavouriteRepository: MockFavouriteProductsRepository!
    
    override func setUp() {
        super.setUp()
        mockFavouriteRepository = MockFavouriteProductsRepository()
        favouriteProductsUseCase = FavouriteProductsUseCase(repository: mockFavouriteRepository)
    }
    
    func testFetchProductsSuccess() {
        let product1 = ProductDomainModel(id: 9, title: "WD 2TB Elements Portable External Hard Drive - USB 3.0 ", price: 64.0, category: "electronics", description: "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system", image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg")
        let product2 = ProductDomainModel(id: 10, title: "WD 2TB Elements Portable External Hard Drive - USB 3.0 ", price: 64.0, category: "electronics", description: "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system", image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg")
        let expectedProducts = [product1, product2]
        mockFavouriteRepository.mockedProducts = expectedProducts

        favouriteProductsUseCase.fetchFavouriteProducts({ result in
            if case .success(let products) = result {
                XCTAssertEqual(products.count, expectedProducts.count)
                XCTAssertEqual(products.first?.title, product1.title)
            }
        })
    }

    func testFetchProductsFailure() {
        let expectedError = NetworkError.invalidURL
        mockFavouriteRepository.mockedError = expectedError
        favouriteProductsUseCase.fetchFavouriteProducts({ result in
            if case .failure(let error) = result {
                XCTAssertTrue(error is NetworkError)
            }
        })
    }
}
