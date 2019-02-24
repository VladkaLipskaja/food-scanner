//
//  ScanViewController.swift
//  int20h
//
//  Created by Alex Vihlayew on 2/23/19.
//  Copyright © 2019 Alex Vihlayew. All rights reserved.
//

import UIKit
import AVFoundation

class ScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var okImageView: UIImageView!
    @IBOutlet weak var qrWatermark: UIImageView!
    @IBOutlet weak var scanningWatermark: UILabel!
    @IBOutlet weak var settingsWatermark: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var components = [String]()
    
    var detectedCode: String? {
        didSet {
            guard let code = detectedCode else { return }
            print("✅ Detected: \(code)")
            API.getComponents(for: code) { (error, _components) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    let allComponents = _components
                    let undesirable = Preferences.undesiredProducts.filter({ (product) -> Bool in
                        return allComponents.contains(product)
                    })
                    self.components = undesirable
                    self.tableView.reloadData()
                    if self.components.isEmpty {
                        self.okImageView.isHidden = false
                    } else {
                        self.okImageView.isHidden = true
                    }
                }
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var captureSession: AVCaptureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Set the input device on the capture session.
            captureSession.addInput(input)
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [
                .code128,
                .code39,
                .code93,
                .ean13,
                .ean8,
                .qr,
                .upce
            ]
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            // Start video capture.
            captureSession.startRunning()
            
            // Move the message label and top bar to the front
            view.bringSubviewToFront(settingsWatermark)
            view.bringSubviewToFront(qrWatermark)
            view.bringSubviewToFront(scanningWatermark)
            view.bringSubviewToFront(tableView)
            view.bringSubviewToFront(okImageView)
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            print("No QR code is detected")
            return
        }
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
        if let code = metadataObj.stringValue {
            if detectedCode != code {
                detectedCode = code
            }
        }
    }
    
    @IBAction func settings(_ sender: Any) {
        performSegue(withIdentifier: "Settings", sender: nil)
    }
    
}

extension ScanViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ComponentCell
        cell.label.text = components[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.alpha = 0
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
    }
    
}
