//
//  FavouriteProductsUseCase.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 22/01/24.
//

import Foundation

final class FavouriteProductsUseCase: FetchFavouriteProductsUseCaseProtocol {
    private let repository: FavouriteProductsRepositoryProtocol

    init(repository: FavouriteProductsRepositoryProtocol) {
        self.repository = repository
    }

    func fetchFavouriteProducts(_ completion: @escaping (Result<[ProductDomainModel], Error>) -> Void) {
        repository.fetchFavouriteProducts(completion)
    }
}
