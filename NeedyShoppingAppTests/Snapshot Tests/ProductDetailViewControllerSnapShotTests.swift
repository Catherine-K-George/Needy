//
//  ProductDetailViewControllerSnapShotTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 18/01/24.
//

@testable import NeedyShoppingApp
import UIKit

final class ProductDetailViewControllerSnapShotTests: SnapshotTestCase {
    
    var sut: ProductDetailViewController!
    var product: ProductModel =
        ProductModel(id: 9, title: "WD 2TB Elements Portable External Hard Drive - USB 3.0 ", price: 64.0, category: "electronics", description: "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system", image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg")
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }

    func testViewController_WhenProvidedAProductDetail_ShouldDisplayTheProductDetail() {
        let viewModel = ProductDetailViewModel(product)
        sut = ProductDetailViewController.instantiate(creator: { coder in
            ProductDetailViewController(coder: coder, productDetailViewModel: viewModel)
        })
        sut.loadView()
        sut.productTableView?.reload()
        verifyViewController(sut)
    }
}
