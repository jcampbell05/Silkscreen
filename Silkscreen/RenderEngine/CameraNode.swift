//
//  CameraNode.swift
//  Silkscreen
//
//  Created by James Campbell on 5/28/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation
import GPUImage

class CameraNode: OutputNode {
    
    typealias InternalNodeType = GPUImageOutput
    typealias TargetInputNodeType = GPUImageInput
    
    private let videoCameraNode = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: .Back)
    private let simulatorImageNode = GPUImagePicture(image: UIImage(named: "test-image"))
    
    private var outputNode: GPUImageOutput {
        if Platform.isSimulator {
            return simulatorImageNode
        }
        else {
            return videoCameraNode
        }
    }
    
    func addTarget(node: TargetInputNodeType) {
        outputNode.addTarget(node)
        simulatorImageNode.processImage()
    }
}