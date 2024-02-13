//
//  FavouritesListView.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 17/01/24.
//

import SwiftUI
import Kingfisher

struct FavouritesListView<ViewModel>: View where ViewModel: FavouriteViewModelProtocol {
    @ObservedObject var viewModel: ViewModel

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
        .onAppear {
            viewModel.fetchFavouriteProducts()
        }
        .listStyle(PlainListStyle())
        .navigationBarTitle(StringConstants.favouriteScreenTitle, displayMode: .inline)
    }
}
