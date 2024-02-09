//
//  UIActivityIndicator+Extension.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import UIKit

extension UIActivityIndicatorView {
    func stop() {
        DispatchQueue.main.async {
            self.stopAnimating()
        }
    }
    
    func start() {
        DispatchQueue.main.async {
            self.startAnimating()
        }
    }
}
