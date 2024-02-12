//
//  ProductCollectionViewCell.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import UIKit
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    func configureProductCell(_ product: ProductDomainModel?) {
        guard let product = product else { return }
        productLabel.text = product.title
        productPriceLabel.text =  String(format: StringConstants.priceWithDollar, product.price)
        if let imageURL = URL(string: product.image) {
            productImageView.kf.setImage(with: imageURL)
        }
    }
}
