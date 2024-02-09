//
//  ApplicationProtocol.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 16/01/24.
//

import UIKit

protocol ApplicationProtocol {
    func setRootViewController(_ viewController: UIViewController, with transition: UIView.AnimationOptions, in window: UIWindow)
}
