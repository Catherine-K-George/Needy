//
//  ProductDetailViewControllerTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 16/01/24.
//

import XCTest
@testable import NeedyShoppingApp

final class ProductDetailViewControllerTests: XCTestCase {
    
    var viewControllerUnderTest: ProductDetailViewController!
    var product: ProductModel = ProductModel(id: 9, title: "WD 2TB Elements Portable External Hard Drive - USB 3.0 ", price: 64.0, category: "electronics", description: "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system", image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg")
    
    override func setUp() {
        super.setUp()
    }
    
    func testLoadedView() {
        let mockProductDetailViewModel = MockProductDetailViewModel(product: product)
        viewControllerUnderTest = ProductDetailViewController.instantiate(creator: { coder in
            ProductDetailViewController(coder: coder, productDetailViewModel: mockProductDetailViewModel)
        })
        viewControllerUnderTest.loadView()
        viewControllerUnderTest.viewDidLoad()
        XCTAssertNotNil(viewControllerUnderTest)
        XCTAssertNotNil(viewControllerUnderTest.productTableView)
    }
    
    func testTableViewDataSource_NumberOfRows() {
        var mockProductDetailViewModel = MockProductDetailViewModel(product: product)
        viewControllerUnderTest = ProductDetailViewController.instantiate(creator: { coder in
            ProductDetailViewController(coder: coder, productDetailViewModel: mockProductDetailViewModel)
        })
        viewControllerUnderTest.loadView()
        let tableView = UITableView()
        
        let numberOfRows = viewControllerUnderTest.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 3)
    }
    
    func testTableViewDataSource_CellForRow() {
        var mockProductDetailViewModel = MockProductDetailViewModel(product: product)
        viewControllerUnderTest = ProductDetailViewController.instantiate(creator: { coder in
            ProductDetailViewController(coder: coder, productDetailViewModel: mockProductDetailViewModel)
        })
        viewControllerUnderTest.loadView()
        
        let tableView = MockTableView()
        tableView.dequeueCellReturnNil = true
        
        viewControllerUnderTest.productTableView = tableView
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = viewControllerUnderTest.tableView(tableView, cellForRowAt: indexPath)
        XCTAssertTrue(tableView.dequeueCellReturnNil)
    }
    
//    func testCellDequeueFails() {
//        let mockProductDetailViewModel = MockProductDetailViewModel(product)
//        viewControllerUnderTest.productDetailViewModel = nil
//
//        let tableView = MockTableView()
//        tableView.dequeueCellReturnNil = false
//
//        viewControllerUnderTest.productTableView = tableView
//
//        let indexPath = IndexPath(row: 4, section: 0)
//        let cell = viewControllerUnderTest.tableView(tableView, cellForRowAt: indexPath)
//
//        XCTAssertTrue(cell is UITableViewCell)
//    }
//    
    func testTableViewDelegate_HeightForRow() {
        var mockProductDetailViewModel = MockProductDetailViewModel(product: product)
        viewControllerUnderTest = ProductDetailViewController.instantiate(creator: { coder in
            ProductDetailViewController(coder: coder, productDetailViewModel: mockProductDetailViewModel)
        })
        viewControllerUnderTest.loadView()
        let tableView = MockTableView()
        let indexPath = IndexPath(row: 0, section: 0)
        let heightForRow = viewControllerUnderTest.tableView(tableView, heightForRowAt: indexPath)
        XCTAssertEqual(heightForRow, UITableView.automaticDimension)
    }
    
    override func tearDown() {
        viewControllerUnderTest = nil
        super.tearDown()
    }
    
}
