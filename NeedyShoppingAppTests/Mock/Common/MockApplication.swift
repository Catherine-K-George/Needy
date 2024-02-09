//
//  MockApplication.swift
//  NeedyShoppingAppTests
//
//  Created by Catherine George on 16/01/24.
//

import UIKit
@testable import NeedyShoppingApp

class MockApplication: ApplicationProtocol {
    var setRootViewControllerCalled = false
    var mockRootViewController: UIViewController?
    var mockTransition: UIView.AnimationOptions?
    var mockWindow: UIWindow?

    func setRootViewController(_ viewController: UIViewController, with transition: UIView.AnimationOptions, in window: UIWindow) {
        setRootViewControllerCalled = true
        mockRootViewController = viewController
        mockTransition = transition
        mockWindow = window
    }
}
