//
//  MockProductRepository.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 15/01/24.
//

import XCTest
@testable import NeedyShoppingApp

final class MockProductRepository: ProductRepositoryProtocol {
    var mockedProducts: [ProductModel]?
    var mockedError: Error?

    func fetchProducts(category: String, completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        if let mockedError = mockedError {
            completion(.failure(mockedError))
        } else if let mockedProducts = mockedProducts {
            completion(.success(mockedProducts))
        } else {
            completion(.failure(NetworkError.unknown))
        }
    }
}
