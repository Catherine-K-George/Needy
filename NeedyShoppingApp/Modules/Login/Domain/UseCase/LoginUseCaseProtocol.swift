//
//  LoginUseCaseProtocol.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 06/02/24.
//

import Foundation

protocol LoginUseCaseProtocol {
    func login(_ domainModel: LoginRequestDomainModel, completion: @escaping (Result<LoginResponseDomainModel?, Error>) -> Void)
}
