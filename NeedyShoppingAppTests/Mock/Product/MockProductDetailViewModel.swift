//
//  MockProductDetailViewModel.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 07/02/24.
//

import XCTest
@testable import NeedyShoppingApp

class MockProductDetailViewModel: ProductDetailViewModelProtocol {
    var product: ProductModel
    var cellReturnValue: UITableViewCell?

    init(product: ProductModel) {
        self.product = product
    }
    
    func numberOfRows() -> Int {
        return 3
    }
    
    func cell(_ tableView: UITableView, forIndexPath indexPath: IndexPath) -> UITableViewCell {
        return cellReturnValue ?? UITableViewCell()

    }
    
    func title() -> String {
        "testTitle"
    }

}
