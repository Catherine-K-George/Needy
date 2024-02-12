//
//  TabbarViewController.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import UIKit

class TabbarViewController: UITabBarController, StoryboardInstantiatable {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .black
        setTabbarViewControllers()
    }
    
    private func setTabbarViewControllers() {
        let homeViewController = createHomeViewController()
        let favouriteViewController = createFavouriteViewController()
        homeViewController.tabBarItem = UITabBarItem(title: StringConstants.homeScreenTitle, image: UIImage(named: "home"), selectedImage: nil)
        favouriteViewController.tabBarItem = UITabBarItem(title: StringConstants.favouriteScreenTitle, image: UIImage(named: "favourite"), selectedImage: nil)
        viewControllers = [homeViewController, favouriteViewController]
    }
    
    private func createHomeViewController() -> UIViewController {
        let networkManager = NetworkManager.shared
        let serviceConfiguration = ServiceConfiguration(endpoint: NetworkConstants.Endpoints.categories)
        let homeService = HomeService(networkManager: networkManager, serviceConfiguration: serviceConfiguration)
        let categoriesRepository = CategoriesRepository(service: homeService)
        let categoriesUseCase = FetchCategoriesUseCase(repository: categoriesRepository)
        let homeViewModel = HomeViewModel(fetchCategoriesUseCase: categoriesUseCase)
        let homeViewController = HomeViewController.instantiate { coder in
            HomeViewController(coder: coder, homeViewModel: homeViewModel)
        }
        
        return UINavigationController(rootViewController: homeViewController)
    }
    
    private func createFavouriteViewController() -> UIViewController {
        let networkManager = NetworkManager.shared
        let serviceConfiguration = ServiceConfiguration(endpoint: NetworkConstants.Endpoints.products)
        let favouriteService = FavouriteProductsService(networkManager: networkManager)
        let mapper = ProductDataMapper()
        let favouriteRepository = FavouriteProductsRepository(service: favouriteService, mapper: mapper)
        let favouritesUseCase = FavouriteProductsUseCase(repository: favouriteRepository)
        let favouriteViewModel = FavouritesViewModel(fetchFavouritesUseCase: favouritesUseCase)
        let favouriteViewController = FavouritesViewController.instantiate { coder in
            FavouritesViewController(coder: coder, favouritesViewModel: favouriteViewModel)
        }
        return favouriteViewController
    }
}
