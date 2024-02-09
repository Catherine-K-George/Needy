//
//  ProductDetailViewModel.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import UIKit

protocol ProductDetailViewModelProtocol {
    func numberOfRows() -> Int
    func title() -> String
    func cell(_ tableView: UITableView, forIndexPath indexPath: IndexPath) -> UITableViewCell
}

final class ProductDetailViewModel {
    var product: ProductModel
    
    init(_ product: ProductModel) {
        self.product = product
    }
    
}
extension ProductDetailViewModel: ProductDetailViewModelProtocol {
    
    func numberOfRows() -> Int {
        return 2
    }
    
    func title() -> String {
        return product.title
    }
    
    func cell(_ tableView: UITableView, forIndexPath indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StringConstants.Identifiers.productDetailHeaderCell, for: indexPath) as? ProductDetailHeaderCell else { return UITableViewCell() }
            cell.product = product
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StringConstants.Identifiers.productDetailDescriptionCell, for: indexPath) as? ProductDetailDescriptionCell else { return UITableViewCell() }
            cell.product = product
            return cell
        default:
            return UITableViewCell()
        }
    }
 }

