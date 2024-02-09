//
//  FetchProductsUseCase.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 15/01/24.
//

import Foundation

final class FetchProductsUseCase: FetchProductsUseCaseProtocol {
    private let repository: ProductRepositoryProtocol

    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }

    func fetchProducts(category: String, completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        repository.fetchProducts(category: category, completion: completion)
    }
}
