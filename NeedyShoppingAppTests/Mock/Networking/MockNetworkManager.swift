//
//  MockNetworkManager.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 10/01/24.
//

import XCTest
@testable import NeedyShoppingApp

class MockNetworkManager: NetworkClientProtocol {

    var mockedData: Data?
    var mockedError: Error?

    func constructURL(endpoint: String, parameters: [String : String]) -> URL? {
        guard !endpoint.isEmpty else { return nil }
        return URL(string: endpoint)
    }
    
    func fetchData<T: Decodable>(from dataSource: RequestDataSource, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        if let error = mockedError {
            completion(.failure(error))
        } else if let data = mockedData, let decodedResponse = try? JSONDecoder().decode(responseType, from: data) {
            completion(.success(decodedResponse))
        } else {
            let error = NSError(domain: "MockError", code: -1, userInfo: nil)
            completion(.failure(error))
        }
    }
}
