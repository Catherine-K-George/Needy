//
//  UITextfield+Extension.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import SwiftUI

extension UITextField {
    func style() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 4.0
        layer.masksToBounds = true
    }
}
