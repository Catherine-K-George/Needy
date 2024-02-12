//
//  FavouriteProductsRepository.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 22/01/24.
//

import Foundation

final class FavouriteProductsRepository: FavouriteProductsRepositoryProtocol {
    private let service: FavouriteProductsServiceProtocol
    private let mapper: ProductDataMapper

    init(service: FavouriteProductsServiceProtocol, mapper: ProductDataMapper) {
        self.service = service
        self.mapper = mapper
    }

    func fetchFavouriteProducts(_ completion: @escaping (Result<[ProductDomainModel], Error>) -> Void) {
        service.fetchFavouriteProducts { [weak self] result in
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
