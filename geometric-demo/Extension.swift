
//
//  Extension.swift
//  geometric-demo
//
//  Created by Siam System Deverlopment on 24/9/2561 BE.
//  Copyright © 2561 Nopakorn Ganjanasinit. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    func itemWith(colorfulImage: UIImage?, title: String, target: AnyObject, action: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.setImage(colorfulImage, for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 44.0, height: 44.0)
        button.addTarget(target, action: action, for: .touchUpInside)

        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }
}
extension UIViewController {
    func popUpLocationPermission() {
        //send data permission
        let alertLocationPermission = UIAlertController(title: "location permission", message: "please allow your location in setting", preferredStyle: UIAlertControllerStyle.alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingUrl = URL(string: UIApplicationOpenSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingUrl) {
                UIApplication.shared.open(settingUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                })
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertLocationPermission.addAction(settingsAction)
        alertLocationPermission.addAction(cancelAction)
        self.dismiss(animated: true){
            self.present(alertLocationPermission, animated: true, completion: nil)
        }
    }

}
