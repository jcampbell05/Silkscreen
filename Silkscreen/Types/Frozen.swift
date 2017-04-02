//
//  Frozen.swift
//  Silkscreen
//
//  Created by James Campbell on 4/25/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation

// - Remove
class Frozen<T: Collection> {
    
    let value: T
    
    init(value: T) {
        self.value = value
    }
}

