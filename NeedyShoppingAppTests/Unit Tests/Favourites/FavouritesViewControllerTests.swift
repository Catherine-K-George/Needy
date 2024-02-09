//
//  FavouritesViewControllerTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 16/01/24.
//

import XCTest
@testable import NeedyShoppingApp

final class FavouritesViewControllerTests: XCTestCase {

    var viewControllerUnderTest: FavouritesViewController!
    
    override func setUp() {
        super.setUp()
        let favouritesViewModel = FavouritesViewModel(fetchFavouritesUseCase: MockFetchFavouriteProductsUseCase())
        viewControllerUnderTest = FavouritesViewController.instantiate(creator: { coder in
            FavouritesViewController(coder: coder, favouritesViewModel: favouritesViewModel)
        })
        viewControllerUnderTest.loadView()
        viewControllerUnderTest.viewDidLoad()
    }
    
    func testLoadedView() {
        XCTAssertNotNil(viewControllerUnderTest)
    }
}
