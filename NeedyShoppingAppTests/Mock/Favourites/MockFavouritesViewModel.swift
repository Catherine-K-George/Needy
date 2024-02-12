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
    var mockedResult: Result<[ProductDomainModel], Error>?

    var products: [ProductDomainModel]
    
    init(_ products: [ProductDomainModel]) {
        self.products = products
    }
    
    func numberOfItems() -> Int {
        products.count
    }
    
    func product(for indexPath: IndexPath) -> NeedyShoppingApp.ProductDomainModel {
        return products[indexPath.row]
    }
    
    func fetchFavouriteProducts() {
        jsonLoadCalled = true
    }
    
}
