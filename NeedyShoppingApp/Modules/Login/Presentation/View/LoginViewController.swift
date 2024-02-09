//
//  LoginViewController.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import UIKit

class LoginViewController: UIViewController, StoryboardInstantiatable {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var loginViewModel: LoginViewModelProtocol
    var application: ApplicationProtocol = UIApplication.shared
    
    init?(coder: NSCoder, loginViewModel: LoginViewModelProtocol) {
        self.loginViewModel = loginViewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleUI()
    }

    @IBAction func submitButtonTapped(_ sender: UIButton) {
        activityIndicator.start()
        guard let username = usernameTextField.text, let password = passwordTextField.text, !username.isEmpty, !password.isEmpty else {
            activityIndicator.stop()
            return
        }
        invokeLogin(username, password)
    }
    
    func invokeLogin(_ username: String, _ password: String) {
        login(username: username, password: password)
    }
    
    func showErrorAlert() {
        AlertView.showAlert(OnView: self, withTitle: "Failed", message: "Sorry, login failed!!", actions: [.ok])
    }
    
    func showHomeScreen(_ completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            guard let window = self.view.window else { return }
            let tabbarController = TabbarViewController.instantiateFromStoryboard()
            self.application.setRootViewController(tabbarController, with: .transitionFlipFromRight, in: window)
        }
    }
}

// MARK: - Supporting private methods
extension LoginViewController {
    private func styleUI() {
        usernameTextField.style()
        passwordTextField.style()
    }
    
    private func login(username name: String, password: String) {
        loginViewModel.login(withUsername: name, password) { [weak self] success in
            self?.activityIndicator.stop()
            if success {
                self?.showHomeScreen({})
            } else {
                self?.showErrorAlert()
            }
        }
    }
}

