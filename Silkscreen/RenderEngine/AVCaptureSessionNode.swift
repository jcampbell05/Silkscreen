//
//  AVCaptureSessionNode.swift
//  Silkscreen
//
//  Created by James Campbell on 5/5/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation
import AVFoundation

class AVCaptureSessionNode: RenderNode {

    // - How do we specify what format we want from this ?
    // - How do we handle data flow in each node ?
    // - In future will we need to access a more low level system ?
    private let captureSession = AVCaptureSession()
    
    private let dataOutputQueue = dispatch_queue_create("com.silkscreen.queues.data-output", nil)
    private let videoDataOutput = AVCaptureVideoDataOutput()
    private let audioDataOutput = AVCaptureAudioDataOutput()
    
    var latestVideoSampleBuffer: CMSampleBuffer? = nil
    var latestAudioSampleBuffer: CMSampleBuffer? = nil
    
    override init() {
        
        super.init()
        
        captureSession.startRunning()
        
        videoDataOutput.setSampleBufferDelegate(self, queue: dataOutputQueue)
        audioDataOutput.setSampleBufferDelegate(self, queue: dataOutputQueue)
       
        captureSession.addOutput(videoDataOutput)
        captureSession.addOutput(audioDataOutput)
    }
    
    func addInputSource(input: AVCaptureInput) {
        captureSession.addInput(input)
    }
    
    func removeInputSource(input: AVCaptureInput) {
        captureSession.removeInput(input)
    }
    
    override func frameAtTime(time: CMTime) -> Frame {
        let sampleBuffers = [latestVideoSampleBuffer, latestAudioSampleBuffer].flatMap({$0})
        return Frame(sampleBuffers: sampleBuffers)
    }
}

// - What do we do with dropped frames ?
// - Bundle up the latest sample buffers into a frame that we can deliver
extension AVCaptureSessionNode: AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate  {
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        
        switch captureOutput {
        case videoDataOutput:
            latestVideoSampleBuffer = sampleBuffer
            break
            
        case audioDataOutput:
            latestAudioSampleBuffer = sampleBuffer
            break
            
        default:
            break
        }
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didDropSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        
    }
}
