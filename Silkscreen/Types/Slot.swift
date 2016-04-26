//
//  Slot.swift
//  Silkscreen
//
//  Created by James Campbell on 4/26/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation

// - Can this work as a struct so we can get rid of Frozen?
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