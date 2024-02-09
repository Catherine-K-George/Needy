//
//  CategoriesRepository.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 15/01/24.
//

import Foundation

final class CategoriesRepository: CategoriesRepositoryProtocol {
    private let service: HomeServiceProtocol

    init(service: HomeServiceProtocol) {
        self.service = service
    }

    func fetchCategories(completion: @escaping (Result<[String], Error>) -> Void) {
        service.fetchCategories { result in
            completion(result)
        }
    }
}
