//
//  ProductViewControllerSnapShotTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 18/01/24.
//

@testable import NeedyShoppingApp
import UIKit

final class ProductViewControllerSnapShotTests: SnapshotTestCase {
    
    var sut: ProductViewController!
    var products: [ProductModel] = [
        ProductModel(id: 9, title: "WD 2TB Elements Portable External Hard Drive - USB 3.0 ", price: 64.0, category: "electronics", description: "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system", image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg"),
         ProductModel(id: 10, title: "WD 2TB Elements Portable External Hard Drive - USB 3.0 ", price: 64.0, category: "electronics", description: "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system", image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg")
    ]
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }

    func testViewController_WhenProvidedAProductList_ShouldDisplayTheProductCollection() {
        
        let mockProductViewModel = MockProductViewModel(products)
        mockProductViewModel.products = products
        sut = ProductViewController.instantiate(creator: { coder in
            ProductViewController(coder: coder, productViewModel: mockProductViewModel)
        })
        sut.loadView()
        sut.productsCollectionView?.reload()
        verifyViewController(sut)
    }
    
    func testViewController_WhenThereIsNoProducts_ShouldDisplayEmptyCollectionView() {
        let mockProductViewModel = MockProductViewModel([])
        sut = ProductViewController.instantiate(creator: { coder in
            ProductViewController(coder: coder, productViewModel: mockProductViewModel)
        })
        sut.productsCollectionView?.reload()
        verifyViewController(sut)
    }
}
