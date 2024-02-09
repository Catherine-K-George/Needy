//
//  FavouriteProductsRepositoryProtocol.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 06/02/24.
//

import Foundation

protocol FavouriteProductsRepositoryProtocol {
    func fetchFavouriteProducts(_ completion: @escaping (Result<[ProductModel], Error>) -> Void)
}
