//
//  ProductRepository.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 15/01/24.
//

import Foundation

final class ProductRepository: ProductRepositoryProtocol {
    private let service: ProductServiceProtocol

    init(service: ProductServiceProtocol) {
        self.service = service
    }

    func fetchProducts(category: String, completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        service.fetchProducts(category: category) { result in
            completion(result)
        }
    }
}

