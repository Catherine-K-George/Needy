//
//  LoginViewModel.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import Foundation

protocol LoginViewModelProtocol {
    func login(withUsername username: String, _ password: String, completion: @escaping (Bool) -> Void)
}

final class LoginViewModel: ObservableObject {
    @Published var token: String?
    
    private let loginUseCase: LoginUseCaseProtocol
    
    init(loginUseCase: LoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase
    }
}

extension LoginViewModel: LoginViewModelProtocol {
    func login(withUsername username: String, _ password: String, completion: @escaping (Bool) -> Void) {
        let domainModel = LoginRequestDomainModel(username: username, password: password)
        loginUseCase.login(domainModel) { [weak self] result in
            switch result {
            case .success(let response):
                self?.token = response.token
                completion(true)
            case .failure(let error):
                print("Login failed with error: \(error)")
                completion(false)
            }
        }
    }
}
