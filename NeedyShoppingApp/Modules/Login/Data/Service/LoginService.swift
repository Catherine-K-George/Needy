//
//  LoginService.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 05/02/24.
//

import Foundation

protocol LoginServiceProtocol {
    func login(request: LoginRequest, completion: @escaping (Result<LoginResponse, Error>) -> Void)
}

final class LoginService: LoginServiceProtocol {
    private let networkManager: NetworkClientProtocol
    private let serviceConfiguration: ServiceConfigurationProtocol

    init(networkManager: NetworkClientProtocol, serviceConfiguration: ServiceConfigurationProtocol) {
        self.networkManager = networkManager
        self.serviceConfiguration = serviceConfiguration
    }

    func login(request: LoginRequest, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        guard let loginURL = networkManager.constructURL(endpoint: serviceConfiguration.endpoint, parameters: [:]) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let dataSource: RequestDataSource = .remoteURL(url: loginURL, method: .POST, body: request)
        networkManager.fetchData(from: dataSource, responseType: LoginResponse.self) { result in
            completion(result)
        }
    }
}
