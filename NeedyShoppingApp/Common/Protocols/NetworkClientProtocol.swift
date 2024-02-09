//
//  NetworkClientProtocol.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 10/01/24.
//

import Foundation

enum RequestDataSource {
    case localFile(fileName: String, fileExtension: String)
    case remoteURL(url: URL, method: HTTPMethods, body: Encodable? = nil)
}

protocol NetworkClientProtocol {
    func constructURL(endpoint: String, parameters: [String: String]) -> URL?
    func fetchData<T: Decodable>(from dataSource: RequestDataSource, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}
