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
                self.videoCameraNode.captureSession.removeInput($0)
            }
        }
        
        didSet {
            videoDevice.unwrap {
                self.videoCameraNode.captureSession.addInput($0)
            }
        }
    }
    
    var audioDevice: AVCaptureDeviceInput? = nil {
        
        willSet {
            audioDevice.unwrap {
                self.videoCameraNode.captureSession.removeInput($0)
            }
        }
        
        didSet {
            audioDevice.unwrap {
                self.videoCameraNode.captureSession.addInput($0)
            }
        }
    }
    
    private lazy var captureSessionCoordinator: CaptureSessionCoordinator = {
        return CaptureSessionCoordinator(captureSession: self.videoCameraNode.captureSession)
    }()
    
    private let videoCameraNode = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: .Back)
    
    init() {
        
        captureSessionCoordinator.lastVideoFrameDidChange.addSlot {
            $0.lastVideoFrame.unwrap {
                self.videoCameraNode.processVideoSampleBuffer($0)
            }
        }
        
        captureSessionCoordinator.lastAudioFrameDidChange.addSlot {
            $0.lastAudioFrame.unwrap {
                self.videoCameraNode.processAudioSampleBuffer($0)
            }
        }
    }
    
    func addTarget(node: GPUImageInput) {
        videoCameraNode.addTarget(node)
    }
}