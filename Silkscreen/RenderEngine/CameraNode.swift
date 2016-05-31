//
//  CameraNode.swift
//  Silkscreen
//
//  Created by James Campbell on 5/28/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation
import GPUImage

// - Move this back to the camera.
// - Implement own Camera node which makes handling devices easier
class CameraNode: Node {
    private let videoCameraNode = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: .Back)
    private let simulatorImageNode = GPUImagePicture(image: UIImage(named: "test-image"))
    
    func addTarget(node: GPUImageInput) {
        if Platform.isSimulator {
            simulatorImageNode.addTarget(node)
        } else {
            
            videoCameraNode.horizontallyMirrorFrontFacingCamera = false
            videoCameraNode.addTarget(node)
        }
    }
    
    func startRendering() {
        if Platform.isSimulator {
            simulatorImageNode.processImage()
        } else {
            videoCameraNode.startCameraCapture()
        }
    }
    
    func toggleCamera() {
        videoCameraNode.rotateCamera()
    }
}