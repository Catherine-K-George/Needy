//
//  ProductRepository.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 15/01/24.
//

import Foundation

final class ProductRepository: ProductRepositoryProtocol {
    private let service: ProductServiceProtocol
    private let mapper: ProductDataMapper

    init(service: ProductServiceProtocol, mapper: ProductDataMapper) {
        self.service = service
        self.mapper = mapper
    }

    func fetchProducts(category: String, completion: @escaping (Result<[ProductDomainModel], Error>) -> Void) {
        service.fetchProducts(category: category) { [weak self] result in
            switch result {
            case .success(let response):
                let products = response.compactMap { dataModel in
                    return self?.mapper.mapToDomainModel(from: dataModel)
                }
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

