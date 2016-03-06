//
//  ScannerVC.swift
//  autolayout
//
//  Created by Alfian Tinangon on 2/15/16.
//  Copyright © 2016 Alfian. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var scanContainer: UIView!
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = UIColor.blackColor()
        
        initScanner()
        
        
        
    }
    
    //INIT SCANNER METHOD
    
    func initScanner() {
        captureSession = AVCaptureSession()
        
        let videoCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed();
            return;
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        } else {
            failed()
            return
        }
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
        captureSession = nil
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.running == false) {
            captureSession.startRunning();
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.running == true) {
            captureSession.stopRunning();
        }
    }
    
    override func viewDidLayoutSubviews() {
        
        //INIT THE CAPTURE LAYOUT ON THIS OVERIDE METHOD
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
        let bounds:CGRect = self.scanContainer.layer.bounds
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer?.bounds = bounds
        previewLayer?.position = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds))
        
        self.scanContainer.layer.addSublayer(previewLayer);
        self.view.layoutIfNeeded()
        captureSession.startRunning();
    }
    
    //START CAPTURE
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            let readableObject = metadataObject as! AVMetadataMachineReadableCodeObject;
            
            //TRIGER VIBRATE AFTER SCAN
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            foundCode(readableObject.stringValue);
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //HENDLE THE SCAN RESULT
    
    func foundCode(code: String) {
        
        print("+++ SCAN RESULT +++")
        print(code)
        print("--- END ---")
    }
    

    
}
