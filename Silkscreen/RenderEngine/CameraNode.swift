//
//  CameraNode.swift
//  Silkscreen
//
//  Created by James Campbell on 5/28/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation
import GPUImage

// - What do we do with the metadata?
class CameraNode: NSObject, Node, AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate {
    
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
    
    private let sampleBufferQueue = dispatch_queue_create("com.silkscreen.sample-buffer-queue", nil)
    
    private let videoOutput = AVCaptureVideoDataOutput()
    private let audioOutput = AVCaptureAudioDataOutput()
    
    private var captureSession: AVCaptureSession {
        return videoCameraNode.captureSession
    }
    
    private let videoCameraNode = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: .Back)
    
    override init() {
        
        super.init()
        
        videoOutput.setSampleBufferDelegate(self, queue: sampleBufferQueue)
        audioOutput.setSampleBufferDelegate(self, queue: sampleBufferQueue)
        
        videoCameraNode.removeInputsAndOutputs()
        
        captureSession.addOutput(videoOutput)
        captureSession.addOutput(audioOutput)
        
        videoCameraNode.startCameraCapture()
    }
    
    func addTarget(node: GPUImageInput) {
        videoCameraNode.addTarget(node)
    }
    
    @objc func captureOutput(captureOutput: AVCaptureOutput!, didDropSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        // - Do we show warning to the user ?
    }
    
    @objc func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        
        switch captureOutput {
            
        case videoOutput:
            videoCameraNode.processVideoSampleBuffer(sampleBuffer)
            break
            
        case audioOutput:
            videoCameraNode.processAudioSampleBuffer(sampleBuffer)
            break
            
        default:
            break
        }
    }
}