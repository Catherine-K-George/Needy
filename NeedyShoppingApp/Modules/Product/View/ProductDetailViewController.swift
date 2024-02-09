//
//  ProductDetailViewController.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import UIKit

class ProductDetailViewController: UIViewController, StoryboardInstantiatable {
    @IBOutlet weak var productTableView: UITableView!
    
    var productDetailViewModel: ProductDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = productDetailViewModel?.title() ?? ""
    }

}

extension ProductDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productDetailViewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productDetailViewModel?.cell(tableView, forIndexPath: indexPath) ?? UITableViewCell()
        return cell
    }
}

extension ProductDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

