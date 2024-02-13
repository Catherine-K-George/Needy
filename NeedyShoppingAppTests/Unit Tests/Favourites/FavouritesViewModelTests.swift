//
//  FavouritesViewModelTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 19/01/24.
//

import XCTest
@testable import NeedyShoppingApp

final class FavouritesViewModelTests: XCTestCase {
    var viewModel: FavouritesViewModel!
    var mockFetchFavouriteProductsUseCase: MockFetchFavouriteProductsUseCase!
    let product1 = ProductDomainModel(id: 9, title: "WD 2TB Elements Portable External Hard Drive - USB 3.0 ", price: 64.0, category: "electronics", description: "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system", image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg")
    let product2 = ProductDomainModel(id: 10, title: "WD 2TB Elements Portable External Hard Drive - USB 3.0 ", price: 64.0, category: "electronics", description: "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system", image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg")
    
    override func setUp() {
        mockFetchFavouriteProductsUseCase = MockFetchFavouriteProductsUseCase()
    }
    
    func testFetchProductsSuccess() {

        let expectedProducts = [product1, product2]
        viewModel = FavouritesViewModel(fetchFavouritesUseCase: mockFetchFavouriteProductsUseCase)
        viewModel.products = expectedProducts
        viewModel.fetchFavouriteProducts()
        XCTAssertFalse(mockFetchFavouriteProductsUseCase.mockErrorCalled)
        XCTAssertEqual(viewModel.numberOfItems(), 2)
        XCTAssertEqual(viewModel.product(for: IndexPath(row: 0, section: 0)).id, product1.id)
    }

    func testFetchProductsFailure() {
        let expectedError = NetworkError.invalidURL
        mockFetchFavouriteProductsUseCase.mockedError = expectedError
        viewModel = FavouritesViewModel(fetchFavouritesUseCase: mockFetchFavouriteProductsUseCase)
        viewModel.fetchFavouriteProducts()
        XCTAssertFalse(mockFetchFavouriteProductsUseCase.isFetchFavouriteProductsCalled)
        XCTAssertTrue(mockFetchFavouriteProductsUseCase.mockErrorCalled)

    }
}
