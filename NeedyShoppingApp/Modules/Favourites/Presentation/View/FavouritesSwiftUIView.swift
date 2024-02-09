//
//  FavouritesSwiftUIView.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 17/01/24.
//

import SwiftUI

struct FavouritesSwiftUIView: View {
    var viewModel: FavouriteViewModelProtocol
    
    var body: some View {
        FavouritesListView(viewModel: viewModel)
            .onAppear {
                viewModel.fetchFavouriteProducts()
            }
    }
    
}
