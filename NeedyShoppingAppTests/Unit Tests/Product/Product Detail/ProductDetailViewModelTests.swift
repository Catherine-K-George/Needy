//
//  ProductDetailViewModelTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 10/01/24.
//

import XCTest
@testable import NeedyShoppingApp

final class ProductDetailViewModelTests: XCTestCase {
    func testNumberOfRows() {
        let product = ProductDomainModel(id: 9, title: "WD 2TB Elements Portable External Hard Drive - USB 3.0 ", price: 64.0, category: "electronics", description: "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system", image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg")
        let viewModel = ProductDetailViewModel(product)

        let numberOfRows = viewModel.numberOfRows()

        XCTAssertEqual(numberOfRows, 2)
    }

    func testTitle() {
        let product = ProductDomainModel(id: 9, title: "WD 2TB Elements Portable External Hard Drive - USB 3.0 ", price: 64.0, category: "electronics", description: "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system", image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg")
        let viewModel = ProductDetailViewModel(product)

        let title = viewModel.title()

        XCTAssertEqual(title, "WD 2TB Elements Portable External Hard Drive - USB 3.0 ")
    }

    func testCellForRowAtIndexPath() {
        let product = ProductDomainModel(id: 9, title: "WD 2TB Elements Portable External Hard Drive - USB 3.0 ", price: 64.0, category: "electronics", description: "", image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg")
        let viewModel = ProductDetailViewModel(product)
        let tableView = UITableView()

        tableView.register(ProductDetailHeaderCell.self, forCellReuseIdentifier: StringConstants.Identifiers.productDetailHeaderCell)
        tableView.register(ProductDetailDescriptionCell.self, forCellReuseIdentifier: StringConstants.Identifiers.productDetailDescriptionCell)
        let cell1 = viewModel.cell(tableView, forIndexPath: IndexPath(row: 0, section: 0))
        let cell2 = viewModel.cell(tableView, forIndexPath: IndexPath(row: 1, section: 0))
        let cell3 = viewModel.cell(tableView, forIndexPath: IndexPath(row: 2, section: 0))

        XCTAssertTrue(cell1 is ProductDetailHeaderCell)
        XCTAssertTrue(cell2 is ProductDetailDescriptionCell)
        XCTAssertNotNil(cell3)
    }
}
