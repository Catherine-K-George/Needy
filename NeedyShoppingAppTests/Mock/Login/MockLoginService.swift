//
//  MockLoginService.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 06/02/24.
//

import XCTest
@testable import NeedyShoppingApp

final class MockLoginService: LoginServiceProtocol {
    var mockedResult: Result<NeedyShoppingApp.LoginResponse, Error>?

    func login(request: NeedyShoppingApp.LoginRequest, completion: @escaping (Result<NeedyShoppingApp.LoginResponse, Error>) -> Void) {
        if let mockedResult = mockedResult {
            completion(mockedResult)
        } else {
            completion(.failure(NetworkError.unknown))
        }
    }
    

}
