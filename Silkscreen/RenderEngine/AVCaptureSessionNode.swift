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

    // - Input System
    // - Session System
    // - Ouput System
    private let captureSession = AVCaptureSession()
    
    var inputSources: [AVCaptureInputProvider] = []
    
}