//
//  MockFetchProductsUseCase.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 15/01/24.
//

import XCTest
@testable import NeedyShoppingApp

final class MockFetchProductsUseCase: FetchProductsUseCaseProtocol {
    var mockedProducts: [ProductDomainModel]?
    var mockedError: Error?

    func fetchProducts(category: String, completion: @escaping (Result<[ProductDomainModel], Error>) -> Void) {
        if let products = mockedProducts {
            completion(.success(products))
        } else if let error = mockedError {
            completion(.failure(error))
        } else {
            completion(.failure(NetworkError.unknown))
        }
    }
}

final class MockFetchFavouriteProductsUseCase: FetchFavouriteProductsUseCaseProtocol {
    var mockedProducts: [ProductDomainModel]?
    var mockedError: Error?
    var isFetchFavouriteProductsCalled = false
    var mockErrorCalled = false

    func fetchFavouriteProducts(_ completion: @escaping (Result<[ProductDomainModel], Error>) -> Void) {
        if let products = mockedProducts {
            isFetchFavouriteProductsCalled = true
            completion(.success(products))
        } else if let error = mockedError {
            mockErrorCalled = true
            completion(.failure(error))
        } else {
            completion(.failure(NetworkError.unknown))
        }
    }
}
