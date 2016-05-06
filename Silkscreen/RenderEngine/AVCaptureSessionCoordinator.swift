//
//  AVCaptureSessionCoordinator.swift
//  Silkscreen
//
//  Created by James Campbell on 5/5/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation

class AVCaptureSessionCoordinator {
    
    let captureSessionNode = AVCaptureSessionNode()
    
    var cameraSource: CameraAVCaptureInputProvider = .None {
        didSet(oldCameraSource) {
            
            if let oldInput = oldCameraSource.captureInput {
                captureSessionNode.removeInputSource(oldInput)
            }
            
            if let newInput = cameraSource.captureInput {
                captureSessionNode.addInputSource(newInput)
            }
        }
    }
    
    // - Control Cameras
    // - Control Microphones
    // - Controler other settings.
    // - Is this how we should record it ?
    func takeImage() {
        
    }
    
    func takeVideo() {
        
    }
    
    func recordAudio() {
        
    }
}