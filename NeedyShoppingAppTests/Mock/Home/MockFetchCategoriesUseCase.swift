//
//  MockFetchCategoriesUseCase.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 15/01/24.
//

import XCTest
@testable import NeedyShoppingApp

final class MockFetchCategoriesUseCase: FetchCategoriesUseCaseProtocol {
    var mockedResult: Result<[String], Error>?

    func fetchCategories(completion: @escaping (Result<[String], Error>) -> Void) {
        if let mockedResult = mockedResult {
            completion(mockedResult)
        } else {
            completion(.failure(NetworkError.unknown))
        }
    }
}
