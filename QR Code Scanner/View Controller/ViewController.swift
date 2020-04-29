//
//  ViewController.swift
//  QR Code Scanner
//
//  Created by TPFLAP146 on 29/04/20.
//  Copyright © 2020 vijay. All rights reserved.
//

import UIKit


//MARK: - View Controller - Initialization
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Toast.showasync(message: "Initialized", controller: self)
    }
    
}

//MARK: - Button Actions
extension ViewController {
    
    @IBAction func scannerButtonClicked(_ sender: Any) {
        Router.navigateToQRScanner(parentViewController: self)
    }
    
}


//MARK: - QR Scanner - Delegates - Subscribing to scanning events
extension ViewController:QRScannerDelegate {
    
    func scannedResult(text: String) {
        Toast.showasync(message: text, controller: self)
    }
    
}
