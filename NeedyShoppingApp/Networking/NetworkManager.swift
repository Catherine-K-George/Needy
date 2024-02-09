//
//  NetworkingManager.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private var urlSession: URLSessionProtocol

    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func constructURL(endpoint: String, parameters: [String: String] = [:]) -> URL? {
        var components = URLComponents(string: NetworkConstants.baseURL)
        components?.path = endpoint
        
        if !parameters.isEmpty {
            components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        return components?.url
    }
    
    func process<T: Decodable>(_ data: Data?, _ response: URLResponse?, _ error: Error?, completion: @escaping (Result<T, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            let error = NSError(domain: "HTTPError", code: statusCode, userInfo: nil)
            completion(.failure(error))
            return
        }
        
        guard let data = data else {
            let error = NSError(domain: "DataError", code: -1, userInfo: nil)
            completion(.failure(error))
            return
        }
        
        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decodedResponse))
        } catch let decodingError {
            print("Error decoding JSON: \(decodingError)")
            completion(.failure(decodingError))
        }
    }
}

extension NetworkManager: NetworkClientProtocol {
    func fetchData<T: Decodable>(from dataSource: RequestDataSource, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        switch dataSource {
        case .localFile(let fileName, let fileExtension):
            do {
                guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
                    throw NSError(domain: "InvalidURL", code: -1, userInfo: nil)
                }
                
                let jsonData = try Data(contentsOf: url)
                let decodedResponse = try JSONDecoder().decode(T.self, from: jsonData)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        case .remoteURL(let url, let method, let body):
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            if let body = body {
                do {
                    request.httpBody = try JSONEncoder().encode(body)
                } catch {
                    completion(.failure(error))
                    return
                }
            }
            let task = urlSession.dataTask(with: request) { [weak self] (data, response, error) in
                self?.process(data, response, error, completion: completion)
            }
            task.resume()
        }
        
    }
}
