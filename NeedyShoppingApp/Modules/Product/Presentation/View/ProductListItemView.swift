//
//  ProductListItemView.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 17/01/24.
//

import SwiftUI
import Kingfisher

struct ProductListItemView: View {
    var product: ProductDomainModel

    var body: some View {
        HStack(spacing: 10) {
            KFImage(URL(string: product.image))
                .resizable()
                .frame(width: 80, height: 80)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.custom("Palatino Bold", size: 18))
                Text(product.category.capitalized)
                    .font(.custom("PingFang SC Medium", size: 15))
                Text(String(format: StringConstants.priceWithDollar, product.price))
                    .font(.custom("PingFang SC Medium", size: 15))
                    .foregroundColor(.gray)

            }
            Divider().background(Color.black).frame(height: 2)

        }.padding(EdgeInsets(top: 15, leading: 15, bottom: 10, trailing: 10))
    }
}
