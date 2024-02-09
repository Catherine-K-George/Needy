//
//  MockLoginRepository.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 15/01/24.
//
import XCTest
@testable import NeedyShoppingApp

final class MockLoginRepository: LoginRepositoryProtocol {
    var mockedResult: Result<LoginResponseDomainModel, Error>?

    func login(_ domainModel: LoginRequestDomainModel, completion: @escaping (Result<LoginResponseDomainModel, Error>) -> Void) {
        if let mockedResult = mockedResult {
            completion(mockedResult)
        } else {
            completion(.failure(NetworkError.unknown))
        }
    }
}
