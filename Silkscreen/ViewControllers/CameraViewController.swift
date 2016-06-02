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
// - Camera / Audio Controls to control settings for those.
// - Add capture options
// - Add record button
// - Build our own node / device handling system for this part.
// - Add sound equaliser
// - Add Video Setting UI (ISO etc)
class CameraViewController: UIViewController {
    
    private let outputNode = CameraNode()
    
    private let emptyImageView = UIImageView(image: UIImage(named: "test-image"))
    private let videoImageView = GPUImageView()
    
    private let videoDevicePickerViewModel = DevicePickerViewModel(mediaType: AVMediaTypeVideo)
    private let audioDevicePickerViewModel = DevicePickerViewModel(mediaType: AVMediaTypeAudio)
    
    private lazy var videoSourceButton: UIButton = {
        let button = UIButton(type: .System)
        button.addTarget(self, action: #selector(didPressSource), forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    private lazy var audioSourceButton: UIButton = {
        let button = UIButton(type: .System)
        button.addTarget(self, action: #selector(didPressSource), forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    let cameraControlsView = CameraControlsView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        videoDevicePickerViewModel.selectedDeviceDidChangeSignal.addSlot {
            self.outputNode.videoDevice = $0.selectedDevice.captureDevice
            self.updateSourceButton(self.videoSourceButton)
        }
        
        audioDevicePickerViewModel.selectedDeviceDidChangeSignal.addSlot {
            self.outputNode.audioDevice = $0.selectedDevice.captureDevice
            self.updateSourceButton(self.audioSourceButton)
        }
        
        toolbarItems = [
            UIBarButtonItem(customView: videoSourceButton),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(customView: audioSourceButton)
        ]
        
        emptyImageView.frame = view.bounds
        videoImageView.frame = view.bounds
        
        view.addSubview(emptyImageView)
        view.addSubview(videoImageView)
        view.addSubview(cameraControlsView)
        
        // - Make into constants
        cameraControlsView.translatesAutoresizingMaskIntoConstraints = false
        cameraControlsView.backgroundColor = UIColor.greenColor()
        cameraControlsView.widthAnchor.constraintEqualToConstant(100.0).active = true
        cameraControlsView.heightAnchor.constraintEqualToConstant(100.0).active = true
        cameraControlsView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        cameraControlsView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -75.0).active = true
        
        outputNode.addTarget(videoImageView)
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
    
    private func viewModelForSourceButton(sender: UIButton) -> DevicePickerViewModel {
        return (sender == videoSourceButton) ? videoDevicePickerViewModel : audioDevicePickerViewModel
    }
    
    @objc private func didPressSource(sender: UIButton) {
        
        let viewModel = viewModelForSourceButton(sender)
        let viewController = DevicePickerViewController(viewModel: viewModel)
        
        viewController.modalPresentationStyle = .Popover
        
        viewController.popoverPresentationController?.sourceView = sender
        viewController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: sender.frame.width, height: sender.frame.height)
        
        presentViewController(viewController, animated: true, completion: nil)
    }
    
    private func updateSourceButton(sender: UIButton) {
    
        let titleFormat = (sender == videoSourceButton) ? NSLocalizedString("Video Source: %@", comment:"") : NSLocalizedString("Audio Source: %@", comment:"")
        let viewModel = viewModelForSourceButton(sender)
        let deviceName = viewModel.selectedDevice.localizedName ?? ""
        let title = String(format: titleFormat, deviceName)
        
        sender.setTitle(title, forState: .Normal)
        sender.sizeToFit()
    }
}