//
//  SplashViewController.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import UIKit

class SplashViewController: UIViewController, StoryboardInstantiatable {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadLoginViewControllerAfterDelay()
    }
    
}

// MARK: - Private methods
extension SplashViewController {
    private func showLoginViewController(loginViewModel viewModel: LoginViewModel) {
        guard self.isViewLoaded && (self.view.window != nil) else {
            return
        }
        
        let loginViewController = LoginViewController.instantiate { coder in
            LoginViewController(coder: coder, loginViewModel: viewModel)
        }
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true)
    }
    
    private func loadLoginViewControllerAfterDelay() {
        let networkManager = NetworkManager.shared
        let serviceConfiguration = ServiceConfiguration(endpoint: NetworkConstants.Endpoints.login)
        let loginService = LoginService(networkManager: networkManager, serviceConfiguration: serviceConfiguration)
        let loginRepository = LoginRepository(service: loginService)
        let loginUseCase = LoginUseCase(repository: loginRepository)
        let loginViewModel = LoginViewModel(loginUseCase: loginUseCase)
        // 0.5s Delay to load splash
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.showLoginViewController(loginViewModel: loginViewModel)
        }
    }
}
