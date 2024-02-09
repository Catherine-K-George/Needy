//
//  MockProductViewModel.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 16/01/24.
//

import Foundation
@testable import NeedyShoppingApp

class MockProductViewModel: ProductViewModelProtocol {
    var fetchProductsCalled = false
    var selectedCategory: String = "electronics"
    var products: [ProductModel]
    var mockedResult: Result<[ProductModel], Error>?

    init(_ products: [ProductModel]) {
        self.products = products
    }

    func numberOfItems() -> Int {
        products.count
    }
    
    func product(for indexPath: IndexPath) -> NeedyShoppingApp.ProductModel {
        products[indexPath.row]
    }
    
    func fetchProducts(completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        fetchProductsCalled = true
        if let mockedResult = mockedResult {
            completion(mockedResult)
        } else {
            completion(.failure(NetworkError.unknown))
        }
    }
}
