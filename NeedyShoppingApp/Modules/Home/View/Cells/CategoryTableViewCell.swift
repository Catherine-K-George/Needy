//
//  CategoryTableViewCell.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func favouriteButtonTapped(_ sender: UIButton) { }
    
    func configureCell(_ category: String) {
        categoryLabel.text = category.capitalized
    }
}
