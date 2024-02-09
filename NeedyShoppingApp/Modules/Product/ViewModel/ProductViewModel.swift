//
//  ProductViewModel.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import Foundation

class ProductViewModel: ObservableObject {
    @Published var selectedCategory = ""
    var products: [ProductModel] = []

    private let fetchProductsUseCase: FetchProductsUseCaseProtocol

    init(category: String, fetchProductsUseCase: FetchProductsUseCaseProtocol) {
        self.selectedCategory = category
        self.fetchProductsUseCase = fetchProductsUseCase
    }

    func numberOfItems() -> Int {
        return products.count
    }

    func product(for indexPath: IndexPath) -> ProductModel {
        return products[indexPath.item]
    }

    func fetchProducts(completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        fetchProductsUseCase.fetchProducts(category: selectedCategory) { [weak self] result in
            switch result {
            case .success(let productResponse):
                self?.products = productResponse
                completion(.success(productResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
