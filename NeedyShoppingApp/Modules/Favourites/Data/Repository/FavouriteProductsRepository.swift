//
//  FavouriteProductsRepository.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 22/01/24.
//

import Foundation

final class FavouriteProductsRepository: FavouriteProductsRepositoryProtocol {
    private let service: FavouriteProductsServiceProtocol

    init(service: FavouriteProductsServiceProtocol) {
        self.service = service
    }

    func fetchFavouriteProducts(_ completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        service.fetchFavouriteProducts { result in
            completion(result)
        }
    }
}
