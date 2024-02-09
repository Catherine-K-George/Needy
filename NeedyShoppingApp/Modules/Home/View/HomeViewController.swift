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
    var homeViewModel: HomeViewModel?
    var application: ApplicationProtocol = UIApplication.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        title = StringConstants.homeScreenTitle
        setHomeHeader()
        setViewModel()
        invokeCategoryFetch()
    }
    
    func invokeCategoryFetch() {
        fetchAllCategories()
    }
    
    func setHomeHeader() {
        welcomeLabel.text = String(format: StringConstants.homeWelcomeHeader, homeViewModel?.retrieveUsername() ?? "")
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
    private func setViewModel() {
        let categoryRepository = CategoriesRepository(networkManager: NetworkManager.shared, endpoint: NetworkConstants.Endpoints.categories)
        let fetchCategoryUseCase = FetchCategoriesUseCase(repository: categoryRepository)
        homeViewModel = HomeViewModel(fetchCategoriesUseCase: fetchCategoryUseCase)
    }
    
    private func fetchAllCategories() {
        activityIndicator.start()
        homeViewModel?.fetchProductCategories { [weak self] result in
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
        return homeViewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StringConstants.Identifiers.categoryCell, for: indexPath) as? CategoryTableViewCell else { return UITableViewCell() }
        if let viewModel = homeViewModel {
            cell.configureCell(viewModel.categoryTitle(for: indexPath))
        }
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productViewController = ProductViewController.instantiateFromStoryboard()
        productViewController.setViewModel(withCategory: homeViewModel?.categoryTitle(for: indexPath) ?? "")
        navigationController?.pushViewController(productViewController, animated: false)
    }
}
