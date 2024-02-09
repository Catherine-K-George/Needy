//
//  MockCollectionView.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 19/01/24.
//

import UIKit
@testable import NeedyShoppingApp

final class MockCollectionView: UICollectionView {
    var dequeueCellReturnNil = false
    var reloadDataCalled = false
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func reloadData() {
        reloadDataCalled = true
    }
    
    override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
        if dequeueCellReturnNil {
            return UICollectionViewCell()
        } else {
            // Implement actual cell dequeuing logic if needed
            return super.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        }
    }
}
