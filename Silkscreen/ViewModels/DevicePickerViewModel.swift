//
//  DevicePickerViewModel.swift
//  Silkscreen
//
//  Created by James Campbell on 5/29/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation
import AVFoundation

// - BDD This
// - Implement None State
// - Signal for device changes.
class DevicePickerViewModel {
    
    // - Move into render engine and rename to device source.
    enum Device: Equatable {
        
        var localizedName: String {
            switch self {
                
            case .Some(let device):
                return device.localizedName
                
            default:
                return NSLocalizedString("None", comment:"")
            }
        }
        
        var captureDevice: AVCaptureDevice? {
            switch self {
            
            case .Some(let device):
            return device
                
            default:
            return nil
            }
        }
        
        case None
        case Some(AVCaptureDevice)
    }
    
    private let mediaType: String
    
    private(set) lazy var selectedDeviceDidChangeSignal: Signal<DevicePickerViewModel> = {
        return Signal(sender: self)
    }()
    
    var selectedDevice: Device = .None {
        didSet {
            selectedDeviceDidChangeSignal.trigger()
        }
    }
    
    private(set) var devices: [Device] = []
    
    init(mediaType: String) {
        
        self.mediaType = mediaType
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateDevices), name: AVCaptureDeviceWasConnectedNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateDevices), name: AVCaptureDeviceWasDisconnectedNotification, object: nil)
        
        updateDevices()
        
        if let defaultDevice = AVCaptureDevice.defaultDeviceWithMediaType(mediaType) {
            selectedDevice = .Some(defaultDevice)
        } else {
            selectedDevice = .None
        }
    }
    
    @objc private func updateDevices() {
        let captureDevices: [Device] = (AVCaptureDevice.devicesWithMediaType(mediaType) as! [AVCaptureDevice]).map {
            return .Some($0)
        }
        
        devices = [.None] + captureDevices
    }
}

func == (lhs: DevicePickerViewModel.Device, rhs: DevicePickerViewModel.Device) -> Bool {
    switch (lhs, rhs) {
    case (.Some(let lhsDevice), .Some(let rhsDevice)):
        return lhsDevice == rhsDevice
    case (.None, .None):
        return true
    default:
        return false
    }
}