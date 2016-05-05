//
//  CameraAVCaptureInputProvider.swift
//  Silkscreen
//
//  Created by James Campbell on 5/5/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation
import AVFoundation

enum CameraAVCaptureInputProvider: AVCaptureInputProvider {
    
    var inputCaptureDevice: AVCaptureInput? {
        switch self {
        case .Front:
            return nil
        case .Back:
            return nil
        default:
            return nil
        }
    }
    
    case Front
    case Back
    case None
}