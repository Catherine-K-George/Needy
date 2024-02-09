//
//  LoginUseCase.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 15/01/24.
//

import Foundation

final class LoginUseCase: LoginUseCaseProtocol {
    private let repository: LoginRepositoryProtocol

    init(repository: LoginRepositoryProtocol) {
        self.repository = repository
    }

    func login(_ domainModel: LoginRequestDomainModel, completion: @escaping (Result<LoginResponseDomainModel, Error>) -> Void) {
        repository.login(domainModel) { result in
            completion(result)
        }
    }
}
