//
//  FetchFavouriteProductsUseCaseProtocol.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 06/02/24.
//

import Foundation

protocol FetchFavouriteProductsUseCaseProtocol {
    func fetchFavouriteProducts(_ completion: @escaping (Result<[ProductDomainModel], Error>) -> Void)
}
