//
//  Signal.swift
//  Silkscreen
//
//  Created by James Campbell on 4/26/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation

// - Can this work as a struct so we can get rid of Frozen?
class Signal {
    
    private var slots = Frozen<[Slot]>(value: [])
    
    func trigger() {
        slots.value.forEach {
            $0.callback?()
        }
    }
    
    func addSlot(callback: () -> Void) -> Slot {
        let slot = Slot(signal: self)
        slot.callback = callback
        
        slots = Frozen<[Slot]>(value: slots.value + [slot])
        return slot
    }
    
    func removeSlot(slot: Slot) {
        
        let newSlots = slots.value.filter {
            $0.signalID != slot.signalID
        }
        
        slots = Frozen(value: newSlots)
    }
}