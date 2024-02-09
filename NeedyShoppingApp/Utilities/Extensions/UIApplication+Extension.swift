//
//  UIApplication+Extension.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 16/01/24.
//

import UIKit

extension UIApplication: ApplicationProtocol {
    func setRootViewController(_ viewController: UIViewController, with transition: UIView.AnimationOptions, in window: UIWindow) {
        UIView.transition(with: window,
                          duration: 0.5,
                          options: transition,
                          animations: {
            window.rootViewController = viewController
        },
                          completion: nil)
    }
}
