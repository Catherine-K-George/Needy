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
        let productDetailViewController = createProductDetailViewController(for: product)
        return productDetailViewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update any relevant UI elements or data if needed
    }
    
    private func createProductDetailViewController(for product: ProductModel) -> UIViewController {
        let productDetailViewModel = ProductDetailViewModel(product)
        let productDetailViewController = ProductDetailViewController.instantiate { coder in
            ProductDetailViewController(coder: coder, productDetailViewModel: productDetailViewModel)
        }
        return productDetailViewController
    }
}
