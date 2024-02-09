//
//  SceneDelegate.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = SplashViewController.instantiateFromStoryboard() 
        window?.makeKeyAndVisible()
    }

}

extension SceneDelegate {
    func setTabBarControllerAsRoot() {
        let tabBarViewController = TabbarViewController.instantiateFromStoryboard()
        guard let window = window else { return }
        let application: ApplicationProtocol = UIApplication.shared
        application.setRootViewController(tabBarViewController, with: .transitionFlipFromRight, in: window)
    }
}
