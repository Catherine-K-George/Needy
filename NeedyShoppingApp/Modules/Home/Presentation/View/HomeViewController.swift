//
//  HomeViewController.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import UIKit

class HomeViewController: UIViewController, StoryboardInstantiatable {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var homeTableView: UITableView?
    private var homeViewModel: HomeViewModelProtocol
    var application: ApplicationProtocol = UIApplication.shared

    init?(coder: NSCoder, homeViewModel: HomeViewModelProtocol) {
        self.homeViewModel = homeViewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = StringConstants.homeScreenTitle
        setHomeHeader()
        invokeCategoryFetch()
    }
    
    func invokeCategoryFetch() {
        fetchAllCategories()
    }
    
    func setHomeHeader() {
        welcomeLabel.text = String(format: StringConstants.homeWelcomeHeader, homeViewModel.retrieveUsername())
    }
  
    // Logout button action
    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
        // need to clear user session
        guard let window = view.window else { return }
        let networkManager = NetworkManager.shared
        let serviceConfiguration = ServiceConfiguration(endpoint: NetworkConstants.Endpoints.login)
        let loginService = LoginService(networkManager: networkManager, serviceConfiguration: serviceConfiguration)
        let loginRepository = LoginRepository(service: loginService)
        let loginUseCase = LoginUseCase(repository: loginRepository)
        let loginViewModel = LoginViewModel(loginUseCase: loginUseCase)
        let loginViewController = LoginViewController.instantiate { coder in
            LoginViewController(coder: coder, loginViewModel: loginViewModel)
        }
        application.setRootViewController(loginViewController, with: .transitionFlipFromRight, in: window)
    }
}

// MARK: - Private methods
extension HomeViewController {
    private func createProductViewController(for category: String) -> UIViewController {
        let networkManager = NetworkManager.shared
        let serviceConfiguration = ServiceConfiguration(endpoint: NetworkConstants.Endpoints.products)
        let productService = ProductService(networkManager: networkManager, serviceConfiguration: serviceConfiguration)
        let productRepository = ProductRepository(service: productService)
        let productUseCase = FetchProductsUseCase(repository: productRepository)
        let productViewModel = ProductViewModel(category: category, fetchProductsUseCase: productUseCase)
        let productViewController = ProductViewController.instantiate { coder in
            ProductViewController(coder: coder, productViewModel: productViewModel)
        }
        return productViewController
    }

    private func fetchAllCategories() {
        activityIndicator.start()
        homeViewModel.fetchProductCategories { [weak self] result in
            self?.activityIndicator.stop()
            switch result {
            case .success(let categories):
                print("Categories: \(categories)")
                self?.homeTableView?.reload()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StringConstants.Identifiers.categoryCell, for: indexPath) as? CategoryTableViewCell else { return UITableViewCell() }
        cell.configureCell(homeViewModel.categoryTitle(for: indexPath))
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = homeViewModel.categoryTitle(for: indexPath)
        let productViewController = createProductViewController(for: category)
        navigationController?.pushViewController(productViewController, animated: false)
    }
}
