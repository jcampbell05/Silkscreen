//
//  CameraViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/29/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit
import GPUImage
import AVFoundation

// - Source options
// - Camera / Audio Controls to control options for those.
// - Add capture options
// - Add record button
// - Build our own node / device handling system for this part.
class CameraViewController: UIViewController {
    
    private let outputNode = CameraNode()
    private let imageView: GPUImageView = GPUImageView()
    
    private lazy var videoSourceButton: UIButton = {
        let button = UIButton(type: .System)
        button.setTitle("Video", forState: .Normal)
        button.sizeToFit()
        
        button.addTarget(self, action: #selector(didPressSource), forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    private lazy var audioSourceButton: UIButton = {
        let button = UIButton(type: .System)
        button.setTitle("Audio", forState: .Normal)
        button.sizeToFit()
        
        button.addTarget(self, action: #selector(didPressSource), forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // - Make Icon for this
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Toggle", comment: ""), style: .Plain, target: self, action: #selector(didPressToggle))
        toolbarItems = [
            UIBarButtonItem(customView: videoSourceButton),
            UIBarButtonItem(customView: audioSourceButton)
        ]
        
        view.backgroundColor = UIColor.grayColor()
        
        imageView.frame = view.bounds
        view.addSubview(imageView)
        
        outputNode.addTarget(imageView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        outputNode.startRendering()
        
        navigationController?.setToolbarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setToolbarHidden(true, animated: animated)
    }
    
    @objc private func didPressToggle() {
        outputNode.toggleCamera()
    }
    
    @objc private func didPressSource(sender: UIButton) {
        
        let mediaType = (sender == videoSourceButton) ? AVMediaTypeVideo : AVMediaTypeAudio
        let viewController = DevicePickerViewController(mediaType: mediaType)
        
        viewController.modalPresentationStyle = .Popover
        viewController.popoverPresentationController?.sourceView = sender
        
        presentViewController(viewController, animated: true, completion: nil)
    }
}