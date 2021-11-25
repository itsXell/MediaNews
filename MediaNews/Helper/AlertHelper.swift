//
//  AlertHelper.swift
//  MediaNews
//
//  Created by Xell on 25/11/2564 BE.
//

import Foundation
import UIKit

class AlertHelper {
    
    static func showAlert(title: String, alert: String, controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: alert, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        controller.present(alertController, animated: true, completion: nil)
    }
}
