//
//  MockHomeViewModel.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 16/01/24.
//

import Foundation
@testable import NeedyShoppingApp

final class MockHomeViewModel: HomeViewModelProtocol {
    var mockedResult: Result<[String], Error>?

    var categories: [String]
    var fetchProductCategoriesCalled = false
    init(_ categories: [String]) {
        self.categories = categories
    }
    
    func numberOfRows() -> Int {
        categories.count
    }
    
    func categoryTitle(for indexPath: IndexPath) -> String {
        categories[indexPath.row]
    }
    
    func fetchProductCategories(completion: @escaping (Result<[String], Error>) -> Void) {
        fetchProductCategoriesCalled = true
        if let mockedResult = mockedResult {
            completion(mockedResult)
        } else {
            completion(.failure(NetworkError.unknown))
        }
    }
    
    func retrieveUsername() -> String {
        return "testUsername"
    }

}
