//
//  Slot.swift
//  Silkscreen
//
//  Created by James Campbell on 4/26/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation

// - Remove
class Slot<T> {
    
    let signalID: String
    private let signal: Signal<T>
    
    var callback: ((sender: T) -> Void)? = nil
 
    init(signal: Signal<T>) {
        self.signalID = NSUUID().UUIDString
        self.signal = signal
    }
    
    deinit {
        signal.removeSlot(self)
    }
}