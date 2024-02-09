//
//  FavouritesViewController.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import UIKit
import SwiftUI

class FavouritesViewController: UIViewController, StoryboardInstantiatable {
    let hostingController = UIHostingController(rootView: FavouritesSwiftUIView(viewModel:  FavouritesViewModel(fetchFavouritesUseCase: FavouriteProductsUseCase(repository: FavouriteProductsRepository(networkManager: NetworkManager.shared)))))

    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationController = UINavigationController(rootViewController: hostingController)
        addChild(navigationController)
        view.addSubview(navigationController.view)
        navigationController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navigationController.view.topAnchor.constraint(equalTo: view.topAnchor),
            navigationController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        navigationController.didMove(toParent: self)
        
    }

}
