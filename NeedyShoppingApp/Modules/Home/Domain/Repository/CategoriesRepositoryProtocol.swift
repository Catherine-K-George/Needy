//
//  CategoriesRepositoryProtocol.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 06/02/24.
//

import Foundation

protocol CategoriesRepositoryProtocol {
    func fetchCategories(completion: @escaping (Result<[String], Error>) -> Void)
}
