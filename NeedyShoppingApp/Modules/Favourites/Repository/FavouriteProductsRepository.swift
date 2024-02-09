//
//  FavouriteProductsRepository.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 22/01/24.
//

import Foundation

protocol FavouriteProductsRepositoryProtocol {
    func fetchFavouriteProducts(_ completion: @escaping (Result<[ProductModel], Error>) -> Void)
}


class FavouriteProductsRepository: FavouriteProductsRepositoryProtocol {
    private let networkManager: NetworkClientProtocol

    init(networkManager: NetworkClientProtocol) {
        self.networkManager = networkManager
    }

    func fetchFavouriteProducts(_ completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        let dataSource: RequestDataSource = .localFile(fileName: "favourites", fileExtension: "json")

        networkManager.fetchData(from: dataSource, responseType: [ProductModel].self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

