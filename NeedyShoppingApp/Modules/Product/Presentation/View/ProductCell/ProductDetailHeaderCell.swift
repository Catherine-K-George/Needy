//
//  ProductDetailHeaderCell.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import UIKit

class ProductDetailHeaderCell: UITableViewCell {

    @IBOutlet weak var headerImageView: UIImageView?
    @IBOutlet weak var headerLabel: UILabel?
    @IBOutlet weak var categoryLabel: UILabel?
    @IBOutlet weak var styleLabel: UILabel?
    @IBOutlet weak var priceLabel: UILabel?
    
    // @IBAction func buyNowButtonTapped(_ sender: UIButton) { }
    
    var product: ProductModel? {
        didSet {
            guard let product = product else { return }
            headerLabel?.text = product.title
            categoryLabel?.text = product.category.capitalized
            styleLabel?.text = StringConstants.productStaticStyleContent
            priceLabel?.text = String(format: StringConstants.priceWithDollar, product.price)
            if let imageURL = URL(string: product.image) {
                headerImageView?.kf.setImage(with: imageURL)
            }
        }
    }
}
