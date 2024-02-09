//
//  UICollectionView+Extension.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import UIKit

extension UICollectionView {
    func reload() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
