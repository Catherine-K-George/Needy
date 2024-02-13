//
//  ProductService.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 06/02/24.
//

import Foundation

protocol ProductServiceProtocol {
    func fetchProducts(category: String, completion: @escaping (Result<[ProductModel], Error>) -> Void)
}

final class ProductService: ProductServiceProtocol {
    private let networkManager: NetworkClientProtocol
    private let serviceConfiguration: ServiceConfigurationProtocol

    init(networkManager: NetworkClientProtocol, serviceConfiguration: ServiceConfigurationProtocol) {
        self.networkManager = networkManager
        self.serviceConfiguration = serviceConfiguration
    }
    
    func fetchProducts(category: String, completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        let categoryEndpoint = String(format: serviceConfiguration.endpoint, category)
        guard let productURL = networkManager.constructURL(endpoint: categoryEndpoint, parameters: [:]) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let dataSource: RequestDataSource = .remoteURL(url: productURL, method: .GET, body: nil)
        networkManager.fetchData(from: dataSource, responseType: [ProductModel].self) { result in
            completion(result)
        }
    }
}
