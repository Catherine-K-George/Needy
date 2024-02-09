//
//  MockFavouritesViewModel.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 18/01/24.
//

import Foundation
@testable import NeedyShoppingApp

class MockFavouriteProductsViewModel: FavouriteViewModelProtocol {
    var jsonLoadCalled = false
    var mockedResult: Result<[ProductModel], Error>?

    var products: [ProductModel]
    
    init(_ products: [ProductModel]) {
        self.products = products
    }
    
    func numberOfItems() -> Int {
        products.count
    }
    
    func product(for indexPath: IndexPath) -> NeedyShoppingApp.ProductModel {
        return products[indexPath.row]
    }
    
    func fetchFavouriteProducts() {
        jsonLoadCalled = true
    }
    
}
