//
//  CaptureSessionCoordinator.swift
//  Silkscreen
//
//  Created by James Campbell on 6/9/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation
import AVFoundation

class CaptureSessionCoordinator {
    
    private(set) var lastVideoFrame: CMSampleBuffer? = nil
    private(set) var lastAudioFrame: CMSampleBuffer? = nil
    
    private(set) lazy var lastVideoFrameDidChange: Signal<CaptureSessionCoordinator> = {
        return Signal(sender: self)
    }()
    
    private(set) lazy var lastAudioFrameDidChange: Signal<CaptureSessionCoordinator> = {
        return Signal(sender: self)
    }()
    
    private let captureSession: AVCaptureSession
    
    init(captureSession: AVCaptureSession) {
        self.captureSession = captureSession
    }
}