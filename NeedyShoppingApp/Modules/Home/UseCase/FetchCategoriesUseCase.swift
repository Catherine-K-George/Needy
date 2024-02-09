//
//  FetchCategoriesUseCase.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 15/01/24.
//

import Foundation
@testable import NeedyShoppingApp

protocol FetchCategoriesUseCaseProtocol {
    func fetchCategories(completion: @escaping (Result<[String], Error>) -> Void)
}

class FetchCategoriesUseCase: FetchCategoriesUseCaseProtocol {
    private let repository: CategoriesRepositoryProtocol

    init(repository: CategoriesRepositoryProtocol) {
        self.repository = repository
    }

    func fetchCategories(completion: @escaping (Result<[String], Error>) -> Void) {
        repository.fetchCategories(completion: completion)
    }
}
