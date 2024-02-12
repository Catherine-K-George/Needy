//
//  ProductRepositoryProtocol.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 06/02/24.
//

import Foundation

protocol ProductRepositoryProtocol {
    func fetchProducts(category: String, completion: @escaping (Result<[ProductDomainModel], Error>) -> Void)
}
