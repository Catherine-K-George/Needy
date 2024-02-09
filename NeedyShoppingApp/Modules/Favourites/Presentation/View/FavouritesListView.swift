//
//  FavouritesListView.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 17/01/24.
//

import SwiftUI
import Kingfisher

struct FavouritesListView: View {
    var viewModel: FavouriteViewModelProtocol

    var body: some View {
        List(viewModel.products, id: \.self) { item in
            NavigationLink(destination: ProductDetailUIKitView(product: item)) {
                ProductListItemView(product: item)
            }
            .listRowInsets(EdgeInsets())
            .background(Color("lightGrayColor"))
            .padding(10)
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
        .navigationBarTitle(StringConstants.favouriteScreenTitle, displayMode: .inline)
    }
}
