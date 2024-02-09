//
//  ProductListModel.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import Foundation

struct ProductModel: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let price: Double
    let category: String
    let description: String
    let image: String
}
