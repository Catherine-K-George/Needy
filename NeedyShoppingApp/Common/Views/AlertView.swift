//
//  AlertView.swift
//  NeedyShoppingApp
//
//  Created by Catherine George on 09/01/24.
//

import UIKit

class AlertView {
    enum ActionTypes {
        case ok
        case cancel
        
        var alertAction: UIAlertAction {
            switch self {
            case .ok:
                return UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    // Handle Ok logic here
                })
                
            case .cancel:
                return UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                    // Handle Cancel Logic here"
                })
            }
        }
    }
    
    static func showAlert(OnView view: UIViewController, withTitle title: String, message: String, actions: [ActionTypes]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        for action in actions {
            alert.addAction(action.alertAction)
        }
        
        DispatchQueue.main.async {
            view.present(alert, animated: true, completion: nil)
        }
    }
}
