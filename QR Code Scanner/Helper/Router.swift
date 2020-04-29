//
//  Router.swift
//  QR Code Scanner
//
//  Created by TPFLAP146 on 29/04/20.
//  Copyright © 2020 vijay. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Generic Page Navigation
class Router {
    
    static func navigateToQRScanner(parentViewController:UIViewController) {
        DispatchQueue.main.async {
            
            let transition = CATransition()
            transition.duration = 0.4
            transition.type = .push
            transition.subtype = .fromRight
            parentViewController.view.window!.layer.add(transition, forKey: kCATransition)
  
            let storyboard = UIStoryboard(name:"QRScanner", bundle: nil)
            let viewControllerToPresent = storyboard.instantiateViewController(withIdentifier:"QRScannerViewController") as! QRScannerViewController
            
            
            viewControllerToPresent.delegate = (parentViewController as! QRScannerDelegate)
            viewControllerToPresent.modalPresentationStyle = .fullScreen
            
            parentViewController.present(viewControllerToPresent, animated: false, completion: nil)
            
        }
    }
    static func closeViewController(viewController:UIViewController) {
        DispatchQueue.main.async {
            
            //Transition from left to right
            let transition = CATransition()
            transition.duration = 0.4
            transition.type = .push
            transition.subtype = .fromLeft
            viewController.view.window!.layer.add(transition, forKey: kCATransition)
            
            viewController.dismiss(animated: false, completion: nil)
            
        }
    }
    
}

