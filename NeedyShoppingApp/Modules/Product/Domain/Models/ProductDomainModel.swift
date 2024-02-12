//
//  ProductDomainModel.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 12/02/24.
//

import Foundation

struct ProductDomainModel: Identifiable, Hashable {
    let id: Int
    let title: String
    let price: Double
    let category: String
    let description: String
    let image: String
}
