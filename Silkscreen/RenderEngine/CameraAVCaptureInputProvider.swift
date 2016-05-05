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
    
    private var captureDevice: AVCaptureDevice? {
        let availableCameraDevices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo) as? [AVCaptureDevice]
        
        switch self {
            
        case .Front:
            return availableCameraDevices?.filter {
                return $0.position == AVCaptureDevicePosition.Front
                }.first
        case .Back:
            return availableCameraDevices?.filter {
                return $0.position == AVCaptureDevicePosition.Back
                }.first
        default:
            return nil
        }
    }
    
    var captureInput: AVCaptureInput? {
        
        guard let captureDevice = captureDevice else {
            return nil
        }
        
        return try? AVCaptureDeviceInput(device: captureDevice)
    }
    
    case None
    case Front
    case Back
}