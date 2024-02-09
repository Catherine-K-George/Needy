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
    var productViewModel: ProductViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = productViewModel?.selectedCategory.capitalized ?? ""
        invokeProductFetch()
    }
    
    func setViewModel(withCategory category: String) {
        let repository = ProductRepository(networkManager: NetworkManager.shared, endpoint: NetworkConstants.Endpoints.products)
        let useCase = FetchProductsUseCase(repository: repository)
        productViewModel = ProductViewModel(category: category, fetchProductsUseCase: useCase)
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
    private func fetchProducts() {
        activityIndicator.start()
        productViewModel?.fetchProducts { [weak self] result in
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
        return productViewModel?.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        cell.configureProductCell(productViewModel?.product(for: indexPath))
        return cell
    }

}

// MARK: - UICollectionViewDelegate
extension ProductViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let product = productViewModel?.product(for: indexPath) else { return }
        let productDetailViewController = ProductDetailViewController.instantiateFromStoryboard()
        productDetailViewController.productDetailViewModel = ProductDetailViewModel(product)
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
