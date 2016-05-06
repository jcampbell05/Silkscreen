//
//  CameraViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/29/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

// - Add capture options
// - Add record button
class CameraViewController: UIViewController {
    
    // - Audio Output.
    // - Visually render audio.
    let coordinator = AVCaptureSessionCoordinator()
    let player = Player()
    let previewLayer = RenderNodePreviewLayer()
    
    let captureSourceSegmentControl = UISegmentedControl(items: [
        NSLocalizedString("Photo", comment: ""),
        NSLocalizedString("Video", comment: ""),
        NSLocalizedString("Audio", comment: ""),
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = captureSourceSegmentControl
        captureSourceSegmentControl.selectedSegmentIndex = 1
        
        // player.renderNode = coordinator.captureSessionNode
        // previewLayer.player = player
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
        
        coordinator.cameraSource = .Front
    }
}