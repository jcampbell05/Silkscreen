//
//  CameraViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/29/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit
import GPUImage

// - Add capture options
// - Add record button
// - Abstract away GPUImage
class CameraViewController: UIViewController {
    
    let videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: .Back)
    
    let simulator = GPUImagePicture(image: UIImage(named: "test-image"))
    
    let imageView: GPUImageView = GPUImageView()
    
    let captureSourceSegmentControl = UISegmentedControl(items: [
        NSLocalizedString("Photo", comment: ""),
        NSLocalizedString("Video", comment: ""),
        NSLocalizedString("Audio", comment: ""),
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.grayColor()
        
        navigationItem.titleView = captureSourceSegmentControl
        captureSourceSegmentControl.selectedSegmentIndex = 1
        
        if Platform.isSimulator {
            simulator.addTarget(imageView)
            simulator.processImage()
        }
        else {
            videoCamera.addTarget(imageView)
        }
        
        imageView.frame = view.bounds
        view.addSubview(imageView)
    }
}