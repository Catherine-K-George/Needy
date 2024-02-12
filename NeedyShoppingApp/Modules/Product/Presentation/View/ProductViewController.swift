//
//  ProductViewController.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import UIKit

class ProductViewController: UIViewController, StoryboardInstantiatable {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    private var productViewModel: ProductViewModelProtocol
    
    init?(coder: NSCoder, productViewModel: ProductViewModelProtocol) {
        self.productViewModel = productViewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = productViewModel.selectedCategory.capitalized
        invokeProductFetch()
    }
    
    func invokeProductFetch() {
        fetchProducts()
    }
    
    func reloadData() {
        productsCollectionView.reload()
    }
}

// MARK: - Private methods
extension ProductViewController {
    
    private func createProductDetailViewController(for product: ProductDomainModel) -> UIViewController {
        let productDetailViewModel = ProductDetailViewModel(product)
        let productDetailViewController = ProductDetailViewController.instantiate { coder in
            ProductDetailViewController(coder: coder, productDetailViewModel: productDetailViewModel)
        }
        return productDetailViewController
    }
    
    private func fetchProducts() {
        activityIndicator.start()
        productViewModel.fetchProducts { [weak self] result in
            self?.activityIndicator.stop()
            switch result {
            case .success(let products):
                print("Products: \(products)")
                self?.reloadData()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ProductViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productViewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        cell.configureProductCell(productViewModel.product(for: indexPath))
        return cell
    }

}

// MARK: - UICollectionViewDelegate
extension ProductViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = productViewModel.product(for: indexPath)
        let productDetailViewController = createProductDetailViewController(for: product)
        navigationController?.pushViewController(productDetailViewController, animated: false)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProductViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/2
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}
