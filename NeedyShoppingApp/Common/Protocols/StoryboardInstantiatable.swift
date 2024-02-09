//
//  StoryboardInstantiatable.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import UIKit

protocol StoryboardInstantiatable { }

extension StoryboardInstantiatable where Self: UIViewController {
    static func instantiateFromStoryboard(storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) -> Self {
        guard let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? Self else {
            fatalError("Failed to instantiate view controller from storyboard.")
        }
        return viewController
    }
    
    static func instantiate(storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil), creator: @escaping((NSCoder) -> Self?)) -> Self {
        let viewController = storyboard.instantiateViewController(identifier: String(describing: self), creator: creator)
        return viewController
    }
}
