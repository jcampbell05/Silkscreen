//
//  Slot.swift
//  Silkscreen
//
//  Created by James Campbell on 4/26/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation

// - Remove
class Slot {
    
    let signalID: String
    private let signal: Signal
    
    var callback: (() -> Void)? = nil
 
    init(signal: Signal) {
        self.signalID = NSUUID().UUIDString
        self.signal = signal
    }
    
    func trigger() {
        
    }
    
    deinit {
        signal.removeSlot(self)
    }
}