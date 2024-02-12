//
//  LoginRepository.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 15/01/24.
//

import Foundation

final class LoginRepository: LoginRepositoryProtocol {
    private let service: LoginServiceProtocol
    
    init(service: LoginServiceProtocol) {
        self.service = service
    }
    
    func login(_ domainModel: LoginRequestDomainModel, completion: @escaping (Result<LoginResponseDomainModel, Error>) -> Void) {
        let loginDataModel = LoginRequestModelMapper.mapToDataModel(from: domainModel)

        service.login(request: loginDataModel) { result in
            switch result {
            case .success(let response):
                let responseDomainModel = LoginResponseModelMapper.mapToDomainModel(from: response)
                completion(.success(responseDomainModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
