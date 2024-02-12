//
//  LoginRepository.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 15/01/24.
//

import Foundation

final class LoginRepository: LoginRepositoryProtocol {
    private let service: LoginServiceProtocol
    private let requestMapper: LoginRequestModelMapper
    private let responseMapper: LoginResponseModelMapper

    init(service: LoginServiceProtocol, requestMapper: LoginRequestModelMapper, responseMapper: LoginResponseModelMapper) {
        self.service = service
        self.requestMapper = requestMapper
        self.responseMapper = responseMapper
    }
    
    func login(_ domainModel: LoginRequestDomainModel, completion: @escaping (Result<LoginResponseDomainModel?, Error>) -> Void) {
        let loginDataModel = requestMapper.mapToDataModel(from: domainModel)

        service.login(request: loginDataModel) { [weak self] result in
            switch result {
            case .success(let response):
                let responseDomainModel = self?.responseMapper.mapToDomainModel(from: response)
                completion(.success(responseDomainModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
