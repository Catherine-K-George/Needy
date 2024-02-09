//
//  MockFavouriteProductsRepository.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 07/02/24.
//

import XCTest
@testable import NeedyShoppingApp

final class MockFavouriteProductsRepository: FavouriteProductsRepositoryProtocol {
    var mockedProducts: [ProductModel]?
    var mockedError: Error?

    func fetchFavouriteProducts(_ completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        if let mockedError = mockedError {
            completion(.failure(mockedError))
        } else if let mockedProducts = mockedProducts {
            completion(.success(mockedProducts))
        } else {
            completion(.failure(NetworkError.unknown))
        }
    }
}

final class MockFavouriteProductsService: FavouriteProductsServiceProtocol {
    var mockedResult: Result<[NeedyShoppingApp.ProductModel], Error>?

    func fetchFavouriteProducts(_ completion: @escaping (Result<[NeedyShoppingApp.ProductModel], Error>) -> Void) {
        if let mockedResult = mockedResult {
            completion(mockedResult)
        } else {
            completion(.failure(NetworkError.unknown))
        }
    }
    
}
