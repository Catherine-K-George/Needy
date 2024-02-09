//
//  FavouritesViewModel.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 18/01/24.
//

import Foundation

protocol FavouriteViewModelProtocol {
    var products: [ProductModel] { get set }
    func numberOfItems() -> Int
    func product(for indexPath: IndexPath) -> ProductModel
    func fetchFavouriteProducts()
}

final class FavouritesViewModel: ObservableObject {
    
    @Published var products: [ProductModel] = []
    private let fetchFavouritesUseCase: FetchFavouriteProductsUseCaseProtocol
    
    init(fetchFavouritesUseCase: FetchFavouriteProductsUseCaseProtocol) {
        self.fetchFavouritesUseCase = fetchFavouritesUseCase
    }
}

extension FavouritesViewModel: FavouriteViewModelProtocol {
    func numberOfItems() -> Int {
        return products.count
    }
    
    func product(for indexPath: IndexPath) -> ProductModel {
        return products[indexPath.item]
    }
    
    func fetchFavouriteProducts() {
        fetchFavouritesUseCase.fetchFavouriteProducts { [weak self] result in
            switch result {
            case .success(let response):
                self?.products = response
            case .failure(let error):
                print("Error: Unable to load favourites", error.localizedDescription)
            }
        }
    }
}
