//
//  MockTableView.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 16/01/24.
//

import UIKit
@testable import NeedyShoppingApp

final class MockTableView: UITableView {
    var dequeueCellReturnNil = false
    var reloadDataCalled = false
    
    override func reloadData() {
        reloadDataCalled = true
    }
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        if dequeueCellReturnNil {
            return UITableViewCell()
        } else {
            // Implement actual cell dequeuing logic if needed
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
}
