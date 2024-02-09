//
//  ProductDetailViewController.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import UIKit

class ProductDetailViewController: UIViewController, StoryboardInstantiatable {
    @IBOutlet weak var productTableView: UITableView!
    
    private var productDetailViewModel: ProductDetailViewModelProtocol
    
    init?(coder: NSCoder, productDetailViewModel: ProductDetailViewModelProtocol) {
        self.productDetailViewModel = productDetailViewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = productDetailViewModel.title()
    }

}

extension ProductDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productDetailViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productDetailViewModel.cell(tableView, forIndexPath: indexPath)
        return cell
    }
}

extension ProductDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

