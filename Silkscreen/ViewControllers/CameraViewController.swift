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
    
    let outputNode = VideoCameraNode()
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
        
        outputNode.startRendering()
        
        imageView.frame = view.bounds
        view.addSubview(imageView)
    }
}