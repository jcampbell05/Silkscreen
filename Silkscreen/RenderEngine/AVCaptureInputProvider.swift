//
//  AVCaptureInputProvider.swift
//  Silkscreen
//
//  Created by James Campbell on 5/5/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation
import AVFoundation

protocol AVCaptureInputProvider {
    
    var captureInput: AVCaptureInput? { get }
}