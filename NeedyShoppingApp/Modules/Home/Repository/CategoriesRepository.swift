//
//  CategoriesRepository.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 15/01/24.
//

import Foundation

protocol CategoriesRepositoryProtocol {
    func fetchCategories(completion: @escaping (Result<[String], Error>) -> Void)
}

class CategoriesRepository: CategoriesRepositoryProtocol {
    private let networkManager: NetworkClientProtocol
    private var endpoint: String

    init(networkManager: NetworkClientProtocol, endpoint: String) {
        self.networkManager = networkManager
        self.endpoint = endpoint
    }

    func fetchCategories(completion: @escaping (Result<[String], Error>) -> Void) {
        guard let categoriesURL = networkManager.constructURL(endpoint: endpoint, parameters: [:]) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let dataSource: RequestDataSource = .remoteURL(url: categoriesURL, method: .GET, body: nil)
        networkManager.fetchData(from: dataSource, responseType: [String].self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
