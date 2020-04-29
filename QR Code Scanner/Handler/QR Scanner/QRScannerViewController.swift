//
//  ViewController.swift
//  Sportrush Ambulance
//
//  Created by TPFLAP146 on 22/02/20.
//  Copyright © 2020 spotrush. All rights reserved.
//

import UIKit
import AVFoundation

//MARK: - Protocol - QR Scanner
protocol QRScannerDelegate:class {
    func scannedResult(text:String)
}


//MARK: - View Controller - Initialization
class QRScannerViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var scannerView: UIView!
    
    //QR Scanner - Variables
    var imageOrientation: AVCaptureVideoOrientation?
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var capturePhotoOutput: AVCapturePhotoOutput?
    var delegate: QRScannerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeCamera()
    }
    @IBAction func backButtonClicked(_ sender: Any) {
        Router.closeViewController(viewController: self)
    }
}


//MARK: - Initial Camera Setup
extension QRScannerViewController {
    
    func initializeCamera() {
       
        // Get an instance of the AVCaptureDevice class to initialize a
       guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
           fatalError("No video device found")
       }
                             
       do {
        
           // Get an instance of the AVCaptureDeviceInput class
           let input = try AVCaptureDeviceInput(device: captureDevice)
                  

           captureSession = AVCaptureSession()
                  
           captureSession?.addInput(input)
                  
        
           capturePhotoOutput = AVCapturePhotoOutput()
           capturePhotoOutput?.isHighResolutionCaptureEnabled = true
                  
        
           captureSession?.addOutput(capturePhotoOutput!)
           captureSession?.sessionPreset = .high
                  
        
           let captureMetadataOutput = AVCaptureMetadataOutput()
           captureSession?.addOutput(captureMetadataOutput)
                  
        
           captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
           captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
                  
    
           videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
           videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
           videoPreviewLayer?.frame = view.layer.bounds
           
           //Setting the video layer over scanner view
           scannerView.layer.addSublayer(videoPreviewLayer!)

        
           //start video capture
           captureSession?.startRunning()
                  
       } catch {
           //If any error occurs, simply print it out
           print(error)
           return
       }
    }
    
}

//MARK: - AV Capture - Delegates
extension QRScannerViewController:AVCapturePhotoCaptureDelegate, AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        
        if metadataObjects.count == 0 {
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            if let outputString = metadataObj.stringValue {
                DispatchQueue.main.async {
                    self.delegate?.scannedResult(text: outputString)
                    Router.closeViewController(viewController: self)
                }
            }
        }
        
    }
    
}
