//
//  FavouritesViewController.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import UIKit
import SwiftUI

class FavouritesViewController: UIViewController, StoryboardInstantiatable {

    private var favouritesViewModel: FavouritesViewModel

    init?(coder: NSCoder, favouritesViewModel: FavouritesViewModel) {
        self.favouritesViewModel = favouritesViewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hostingController = UIHostingController(rootView: FavouritesListView(viewModel: self.favouritesViewModel))

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
