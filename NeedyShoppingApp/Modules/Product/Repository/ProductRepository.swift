//
//  ProductRepository.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 15/01/24.
//

import Foundation

protocol ProductRepositoryProtocol {
    func fetchProducts(category: String, completion: @escaping (Result<[ProductModel], Error>) -> Void)
}

final class ProductRepository: ProductRepositoryProtocol {
    private let networkManager: NetworkClientProtocol
    private var endpoint: String

    init(networkManager: NetworkClientProtocol, endpoint: String) {
        self.networkManager = networkManager
        self.endpoint = endpoint
    }

    func fetchProducts(category: String, completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        let categoryEndpoint = String(format: endpoint, category)
        guard let productURL = networkManager.constructURL(endpoint: categoryEndpoint, parameters: [:]) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let dataSource: RequestDataSource = .remoteURL(url: productURL, method: .GET, body: nil)
        networkManager.fetchData(from: dataSource, responseType: [ProductModel].self) { result in
            switch result {
            case .success(let productResponse):
                completion(.success(productResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

