//
//  ProductDetailHeaderCellTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 19/01/24.
//

import XCTest
@testable import NeedyShoppingApp

final class ProductDetailHeaderCellTests: XCTestCase {
    
    let product = ProductDomainModel(id: 9, title: "Portable External Hard Drive", price: 64.0, category: "electronics", description: "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system", image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg")
    var tableView = UITableView()
    var viewModel: ProductDetailViewModel!
    
    override func setUp() {
        viewModel = ProductDetailViewModel(product)
        tableView.register(ProductDetailHeaderCell.self, forCellReuseIdentifier: StringConstants.Identifiers.productDetailHeaderCell)
    }
    
    func testCellProductNotNil() {
        guard let cell = viewModel.cell(tableView, forIndexPath: IndexPath(row: 0, section: 0)) as? ProductDetailHeaderCell else { return }
        cell.product = viewModel.product
        XCTAssertNotNil(cell.product)
    }
    
    func testCellProductNil() {
        guard let cell = viewModel.cell(tableView, forIndexPath: IndexPath(row: 0, section: 0)) as? ProductDetailHeaderCell else { return }
        cell.product = nil
        XCTAssertNil(cell.product)
    }
}
