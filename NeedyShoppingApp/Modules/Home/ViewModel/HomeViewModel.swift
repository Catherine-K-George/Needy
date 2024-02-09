//
//  HomeViewModel.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import Foundation

class HomeViewModel {
    var categories: [String] = []
    private let fetchCategoriesUseCase: FetchCategoriesUseCaseProtocol
    
    init(fetchCategoriesUseCase: FetchCategoriesUseCaseProtocol) {
        self.fetchCategoriesUseCase = fetchCategoriesUseCase
    }

    func numberOfRows() -> Int {
        return categories.count
    }

    func categoryTitle(for indexPath: IndexPath) -> String {
        return categories[indexPath.row]
    }

    func fetchProductCategories(completion: @escaping (Result<[String], Error>) -> Void) {
        fetchCategoriesUseCase.fetchCategories { [weak self] result in
            switch result {
            case .success(let response):
                self?.categories = response
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func retrieveUsername() -> String {
        if let username = UserDefaults.standard.string(forKey: StringConstants.UserDefaults.username) {
            return username
        }
        return ""
    }
}


