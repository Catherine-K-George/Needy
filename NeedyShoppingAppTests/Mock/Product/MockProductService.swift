//
//  MockProductService.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 06/02/24.
//

import XCTest
@testable import NeedyShoppingApp

final class MockProductService: ProductServiceProtocol {
    var mockedResult: Result<[NeedyShoppingApp.ProductModel], Error>?

    func fetchProducts(category: String, completion: @escaping (Result<[NeedyShoppingApp.ProductModel], Error>) -> Void) {
        if let mockedResult = mockedResult {
            completion(mockedResult)
        } else {
            completion(.failure(NetworkError.unknown))
        }
    }
    

    
}
