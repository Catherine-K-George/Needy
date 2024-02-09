//
//  FetchProductsUseCaseProtocol.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 06/02/24.
//

import Foundation

protocol FetchProductsUseCaseProtocol {
    func fetchProducts(category: String, completion: @escaping (Result<[ProductModel], Error>) -> Void)
}
