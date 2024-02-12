//
//  ProductDetailDescriptionCell.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import UIKit

class ProductDetailDescriptionCell: UITableViewCell {

    @IBOutlet weak var favouriteButton: UIButton?
    @IBOutlet weak var descriptionLabel: UILabel?
    
    var product: ProductDomainModel? {
        didSet {
            guard let product = product else { return }
            descriptionLabel?.text = product.description
        }
    }

    @IBAction func favouriteButtonTapped(_ sender: UIButton) {
    }
    
}
