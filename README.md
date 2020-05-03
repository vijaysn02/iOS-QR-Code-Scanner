# QR Code Scanner

## Introduction:

This project is created to understand the working of QR Code Scanner and also to have a ready made component for integration in the projects. 

If you want to implement it straight away, you can make copy the handler in the project and jump to the Usage part.

----------------------------------------------------------------------------------------------------

## Installation:

You dont need a special installation of any cocopods for this. You can use AVFoundation provided by Apple.


----------------------------------------------------------------------------------------------------

## Configuration:

You have to Include the description for Camera Usage permission in your Info.plist 

```
<key>NSCameraUsageDescription</key>
<string>To Scan Qr Code and Bar Code</string>
```

----------------------------------------------------------------------------------------------------

## Coding Part - Handler:

There are two important section of this handler. (i) Initialization and Scanning

### Initialization

```
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
```

### Scanning

```
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
```


----------------------------------------------------------------------------------------------------

## Helper Part

### Toast and Router is used for assisting the main functionality

----------------------------------------------------------------------------------------------------

## Usage Part

### Invoke this specific function to use in your View Controller. Here,making use of Router to facilitate easy implementation

```
    Router.navigateToQRScanner(parentViewController: self)
```

### Subscribe to below delegate to get message from QRScanner ViewController.

```
//MARK: - QR Scanner - Delegates - Subscribing to scanning events
extension ViewController:QRScannerDelegate {
    
    func scannedResult(text: String) {
        Toast.showasync(message: text, controller: self)
    }
    
}
```

### Check out my Post about Project Name : [QR Code Scanner](https://vijaysn.com/mobile/ios/ios-qr-code-scanner)
