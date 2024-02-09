//
//  FavouritesSwiftUIViewTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 18/01/24.
//

import XCTest
import SwiftUI
@testable import NeedyShoppingApp

final class FavouritesSwiftUIViewTests: XCTestCase {
    
    let product = ProductModel(id: 15, title: "Snowboard Jacket Winter Coats", price: 56.99, category: "women\'s clothing", description: "Note:The Jackets is US standard size, Please choose size as your usual wear Material: 100% Polyester; Detachable Liner Fabric: Warm Fleece. Detachable Functional Liner: Skin Friendly, Lightweigt and Warm.Stand Collar Liner jacket, keep you warm in cold weather. Zippered Pockets: 2 Zippered Hand Pockets, 2 Zippered Pockets on Chest (enough to keep cards or keys)and 1 Hidden Pocket Inside.Zippered Hand Pockets and Hidden Pocket keep your things secure. Humanized Design: Adjustable and Detachable Hood and Adjustable cuff to prevent the wind and water,for a comfortable fit. 3 in 1 Detachable Design provide more convenience, you can separate the coat and inner as needed, or wear it together. It is suitable for different season and help you adapt to different climates", image: "https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg")
    
    func testFavouritesSwiftUIView() throws {
        let viewModel = MockFavouriteProductsViewModel([product])
        let view = FavouritesSwiftUIView(viewModel: viewModel)
        let rootView = view.body
        XCTAssertFalse(viewModel.jsonLoadCalled)
        viewModel.fetchFavouriteProducts()
        XCTAssertTrue(viewModel.jsonLoadCalled)
        
    }
    
}
