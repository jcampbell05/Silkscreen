//
//  CameraNode.swift
//  Silkscreen
//
//  Created by James Campbell on 5/28/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation
import GPUImage

class CameraNode: Node {
    
    // - Take AVCaptureDeviceInput instead?
    var videoDevice: AVCaptureDeviceInput? = nil {
        
        willSet {
            videoDevice.unwrap {
                self.captureSession.removeInput($0)
            }
        }
        
        didSet {
            videoDevice.unwrap {
                self.captureSession.addInput($0)
            }
        }
    }
    
    var audioDevice: AVCaptureDeviceInput? = nil {
        
        willSet {
            audioDevice.unwrap {
                self.captureSession.removeInput($0)
            }
        }
        
        didSet {
            audioDevice.unwrap {
                self.captureSession.addInput($0)
            }
        }
    }
    
    private var captureSession: AVCaptureSession {
        return videoCameraNode.captureSession
    }
    
    private let videoCameraNode = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: .Back)
    
    init() {

        
// - Reimplement Here - Build output buffers which call function which pushes to GPUImage
//        captureSessionCoordinator.lastVideoFrameDidChange.addSlot {
//            $0.lastVideoFrame.unwrap {
//                self.videoCameraNode.processVideoSampleBuffer($0)
//            }
//        }
//        
//        captureSessionCoordinator.lastAudioFrameDidChange.addSlot {
//            $0.lastAudioFrame.unwrap {
//                self.videoCameraNode.processAudioSampleBuffer($0)
//            }
//        }
    }
    
    func addTarget(node: GPUImageInput) {
        videoCameraNode.addTarget(node)
    }
}