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
    var products: [ProductDomainModel]
    var mockedResult: Result<[ProductDomainModel], Error>?

    init(_ products: [ProductDomainModel]) {
        self.products = products
    }

    func numberOfItems() -> Int {
        products.count
    }
    
    func product(for indexPath: IndexPath) -> NeedyShoppingApp.ProductDomainModel {
        products[indexPath.row]
    }
    
    func fetchProducts(completion: @escaping (Result<[ProductDomainModel], Error>) -> Void) {
        fetchProductsCalled = true
        if let mockedResult = mockedResult {
            completion(mockedResult)
        } else {
            completion(.failure(NetworkError.unknown))
        }
    }
}
