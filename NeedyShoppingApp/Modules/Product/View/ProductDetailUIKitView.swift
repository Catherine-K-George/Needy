//
//  ProductDetailUIKitView.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 17/01/24.
//

import UIKit
import SwiftUI

struct ProductDetailUIKitView: UIViewControllerRepresentable {
    let product: ProductModel

    func makeUIViewController(context: Context) -> UIViewController {
        let productDetailViewController = ProductDetailViewController.instantiateFromStoryboard()
        productDetailViewController.productDetailViewModel = ProductDetailViewModel(product)
        return productDetailViewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update any relevant UI elements or data if needed
    }
}
