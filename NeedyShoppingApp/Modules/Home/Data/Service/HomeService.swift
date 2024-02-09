//
//  HomeService.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 06/02/24.
//

import Foundation

protocol HomeServiceProtocol {
    func fetchCategories(completion: @escaping (Result<[String], Error>) -> Void)
}

final class HomeService: HomeServiceProtocol {
    private let networkManager: NetworkClientProtocol
    private let serviceConfiguration: ServiceConfiguration

    init(networkManager: NetworkClientProtocol, serviceConfiguration: ServiceConfiguration) {
        self.networkManager = networkManager
        self.serviceConfiguration = serviceConfiguration
    }

    func fetchCategories(completion: @escaping (Result<[String], Error>) -> Void) {
        guard let categoriesURL = networkManager.constructURL(endpoint: serviceConfiguration.endpoint, parameters: [:]) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let dataSource: RequestDataSource = .remoteURL(url: categoriesURL, method: .GET, body: nil)
        networkManager.fetchData(from: dataSource, responseType: [String].self) { result in
            completion(result)
        }
    }
}
