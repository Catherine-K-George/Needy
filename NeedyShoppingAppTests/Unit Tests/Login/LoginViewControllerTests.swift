//
//  LoginViewControllerTests.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 16/01/24.
//

import XCTest
@testable import NeedyShoppingApp

class LoginViewControllerTests: XCTestCase {
    var viewControllerUnderTest: LoginViewController!
    
    override func setUp() {
        super.setUp()
    }
    
    func testLoadedView() {
        let mockLoginViewModel = MockLoginViewModel(success: true)

        viewControllerUnderTest = LoginViewController.instantiate(creator: { coder in
            LoginViewController(coder: coder, loginViewModel: mockLoginViewModel)
        })
        viewControllerUnderTest.loadView()

        XCTAssertNotNil(viewControllerUnderTest)
        XCTAssertNotNil(viewControllerUnderTest.headerLabel)
    }
    
    func testLoginSuccess() {
        let mockLoginViewModel = MockLoginViewModel(success: true)

        viewControllerUnderTest = LoginViewController.instantiate(creator: { coder in
            LoginViewController(coder: coder, loginViewModel: mockLoginViewModel)
        })
        viewControllerUnderTest.loadView()

        viewControllerUnderTest.invokeLogin("testUser", "testPassword")
        XCTAssertTrue(mockLoginViewModel.didCallLogin)
    }
       
    func testLoginFailure() {
        let mockLoginViewModel = MockLoginViewModel(success: false)

        viewControllerUnderTest = LoginViewController.instantiate(creator: { coder in
            LoginViewController(coder: coder, loginViewModel: mockLoginViewModel)
        })
        viewControllerUnderTest.loadView()

        viewControllerUnderTest.invokeLogin("testUser", "testPassword")
        XCTAssertTrue(mockLoginViewModel.didCallLogin)
    }
    
    func testSubmitButtonTapped() {
        let mockLoginViewModel = MockLoginViewModel(success: true)

        viewControllerUnderTest = LoginViewController.instantiate(creator: { coder in
            LoginViewController(coder: coder, loginViewModel: mockLoginViewModel)
        })
        viewControllerUnderTest.loadView()

        viewControllerUnderTest.submitButtonTapped(UIButton())
        XCTAssertFalse(viewControllerUnderTest.activityIndicator.isAnimating)
    }
    
    func testEmptyTextFields() {
        let mockLoginViewModel = MockLoginViewModel(success: true)

        viewControllerUnderTest = LoginViewController.instantiate(creator: { coder in
            LoginViewController(coder: coder, loginViewModel: mockLoginViewModel)
        })
        viewControllerUnderTest.loadView()
        viewControllerUnderTest.viewDidLoad()
        viewControllerUnderTest.usernameTextField.text = nil
        viewControllerUnderTest.passwordTextField.text = nil
        viewControllerUnderTest.submitButtonTapped(UIButton())
        XCTAssertFalse(viewControllerUnderTest.activityIndicator.isAnimating)
    }
    
    func testDeallocatedLoginViewcontroller() {
        let mockLoginViewModel = MockLoginViewModel(success: true)

        viewControllerUnderTest = LoginViewController.instantiate(creator: { coder in
            LoginViewController(coder: coder, loginViewModel: mockLoginViewModel)
        })
        viewControllerUnderTest.loadView()
        viewControllerUnderTest.invokeLogin("testUser", "testPassword")
        viewControllerUnderTest = nil
        XCTAssertNil(viewControllerUnderTest)
    }
    
    override func tearDown() {
        viewControllerUnderTest = nil
        super.tearDown()
    }
}
