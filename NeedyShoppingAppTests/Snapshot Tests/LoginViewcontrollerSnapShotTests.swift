//
//  LoginViewcontrollerSnapShotTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 18/01/24.
//

@testable import NeedyShoppingApp
import UIKit
import SwiftUI
import iOSSnapshotTestCaseCore

final class LoginViewcontrollerSnapShotTests: SnapshotTestCase {
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func testViewController_WhenLoginViewIsReady() {
        let networkManager = NetworkManager.shared
        let serviceConfiguration = ServiceConfiguration(endpoint: NetworkConstants.Endpoints.login)
        let loginService = LoginService(networkManager: networkManager, serviceConfiguration: serviceConfiguration)
        let loginRepository = LoginRepository(service: loginService)
        let loginUseCase = LoginUseCase(repository: loginRepository)
        let loginViewModel = LoginViewModel(loginUseCase: loginUseCase)
        let sut = LoginViewController.instantiate { coder in
            LoginViewController(coder: coder, loginViewModel: loginViewModel)
        }
        sut.loadView()
        verifyViewController(sut)
    }
}
