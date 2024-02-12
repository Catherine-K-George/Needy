//
//  ProductViewModel.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import Foundation

protocol ProductViewModelProtocol {
    var selectedCategory: String { get set }
    func numberOfItems() -> Int
    func product(for indexPath: IndexPath) -> ProductDomainModel
    func fetchProducts(completion: @escaping (Result<[ProductDomainModel], Error>) -> Void)
}

final class ProductViewModel: ObservableObject {
    @Published var selectedCategory = ""
    var products: [ProductDomainModel] = []
    
    private let fetchProductsUseCase: FetchProductsUseCaseProtocol
    
    init(category: String, fetchProductsUseCase: FetchProductsUseCaseProtocol) {
        self.selectedCategory = category
        self.fetchProductsUseCase = fetchProductsUseCase
    }
    
}

extension ProductViewModel: ProductViewModelProtocol {
    func numberOfItems() -> Int {
        return products.count
    }

    func product(for indexPath: IndexPath) -> ProductDomainModel {
        return products[indexPath.item]
    }

    func fetchProducts(completion: @escaping (Result<[ProductDomainModel], Error>) -> Void) {
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
