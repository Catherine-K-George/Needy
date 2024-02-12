//
//  ProductViewControllerTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 16/01/24.
//

import XCTest
@testable import NeedyShoppingApp

final class ProductViewControllerTests: XCTestCase {

    var viewControllerUnderTest: ProductViewController!
    var products: [ProductDomainModel] = [
        ProductDomainModel(id: 9, title: "WD 2TB Elements Portable External Hard Drive - USB 3.0 ", price: 64.0, category: "electronics", description: "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system", image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg"),
        ProductDomainModel(id: 10, title: "WD 2TB Elements Portable External Hard Drive - USB 3.0 ", price: 64.0, category: "electronics", description: "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system", image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg")
    ]
    override func setUp() {
        super.setUp()
    }
    
    func testLoadedView() {
        let mockProductViewModel = MockProductViewModel(products)

        viewControllerUnderTest = ProductViewController.instantiate(creator: { coder in
            ProductViewController(coder: coder, productViewModel: mockProductViewModel)
        })
        viewControllerUnderTest.loadView()
        XCTAssertNotNil(viewControllerUnderTest)
        XCTAssertNotNil(viewControllerUnderTest.productsCollectionView)
    }
    
    func testFetchProducts() {
        var mockProductViewModel = MockProductViewModel(products)
        mockProductViewModel.mockedResult = .success(products)
        viewControllerUnderTest = ProductViewController.instantiate(creator: { coder in
            ProductViewController(coder: coder, productViewModel: mockProductViewModel)
        })
        viewControllerUnderTest.loadView()
        viewControllerUnderTest.invokeProductFetch()
        XCTAssertTrue(mockProductViewModel.fetchProductsCalled)
    }
    
    func testCollectionViewDataSourceNumberOfItems() {
        let mockProductViewModel = MockProductViewModel(products)

        viewControllerUnderTest = ProductViewController.instantiate(creator: { coder in
            ProductViewController(coder: coder, productViewModel: mockProductViewModel)
        })
        viewControllerUnderTest.loadView()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "productCell")
        collectionView.dataSource = viewControllerUnderTest
        
        let numberOfItems = viewControllerUnderTest.collectionView(collectionView, numberOfItemsInSection: 0)
        XCTAssertEqual(numberOfItems, mockProductViewModel.numberOfItems())
    }

    func testCellForRowAtIndex() {
        let mockProductViewModel = MockProductViewModel(products)

        viewControllerUnderTest = ProductViewController.instantiate(creator: { coder in
            ProductViewController(coder: coder, productViewModel: mockProductViewModel)
        })
        viewControllerUnderTest.loadView()

        if let collectionView = viewControllerUnderTest.productsCollectionView {
            
            let indexPath = IndexPath(row: 0, section: 0)
            let cell = viewControllerUnderTest.collectionView(collectionView, cellForItemAt: indexPath)
            
            XCTAssertTrue(cell is ProductCollectionViewCell)
            XCTAssertEqual((cell as? ProductCollectionViewCell)?.productLabel.text, "WD 2TB Elements Portable External Hard Drive - USB 3.0 ")
        }
    }
    
    func testCellDequeueFails() {
        let mockProductViewModel = MockProductViewModel(products)

        viewControllerUnderTest = ProductViewController.instantiate(creator: { coder in
            ProductViewController(coder: coder, productViewModel: mockProductViewModel)
        })
        viewControllerUnderTest.loadView()

        var mockCollectionView = MockCollectionView()
        mockCollectionView.dequeueCellReturnNil = true

        viewControllerUnderTest.productsCollectionView = mockCollectionView

        let indexPath = IndexPath(row: 0, section: 0)
        let cell = viewControllerUnderTest.collectionView(mockCollectionView, cellForItemAt: indexPath)

        XCTAssertTrue(cell is UICollectionViewCell)
    }
    
    func testDidSelectRowAtIndex() {
        var mockProductViewModel = MockProductViewModel(products)
        
        viewControllerUnderTest = ProductViewController.instantiate(creator: { coder in
            ProductViewController(coder: coder, productViewModel: mockProductViewModel)
        })
        viewControllerUnderTest.loadView()
        
        let indexPath = IndexPath(row: 0, section: 0)
        if let collectionView = viewControllerUnderTest.productsCollectionView {
            viewControllerUnderTest.collectionView(collectionView, didSelectItemAt: indexPath)
        }
        XCTAssertEqual(mockProductViewModel.product(for: indexPath).id, 9)
        mockProductViewModel = MockProductViewModel([])
        if let collectionView = viewControllerUnderTest.productsCollectionView {
            viewControllerUnderTest.collectionView(collectionView, didSelectItemAt: indexPath)
        }
        XCTAssertEqual(mockProductViewModel.numberOfItems(), 0)
    }
    
//    func testTableViewReload() {
//        let collectionView = MockCollectionView()
//        viewControllerUnderTest.productsCollectionView = collectionView
//        viewControllerUnderTest.invokeProductFetch()
//        XCTAssertFalse(collectionView.reloadDataCalled)
//        viewControllerUnderTest.productsCollectionView.reloadData()
//        XCTAssertTrue(collectionView.reloadDataCalled)
//    }
    
    override func tearDown() {
        viewControllerUnderTest = nil
        super.tearDown()
    }

}
