//
//  UIViewController+Extension.swift
//  ABCApp
//
//  Created by Boris on 2024/2/29.
//

import UIKit

func getCurrentUIVC() -> UIViewController? {
        guard let superVC = getCurrentVC() else {
            return nil
        }
        
        if let tabBarController = superVC as? UITabBarController {
            if let tabSelectVC = tabBarController.selectedViewController as? UINavigationController {
                return tabSelectVC.viewControllers.last
            } else {
                return tabBarController.selectedViewController
            }
        } else if let navigationController = superVC as? UINavigationController {
            return navigationController.viewControllers.last
        }
        
        return superVC
    }
    
    func getCurrentVC() -> UIViewController? {
        var result: UIViewController?
        
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindow.Level.normal {
            let windows = UIApplication.shared.windows
            for tmpWin in windows {
                if tmpWin.windowLevel == UIWindow.Level.normal {
                    window = tmpWin
                    break
                }
            }
        }
        
        if let frontView = window?.subviews.first {
            if let nextResponder = frontView.next {
                if let viewController = nextResponder as? UIViewController {
                    result = viewController
                } else {
                    result = window?.rootViewController
                }
            }
        }
        
        return result
    
}
