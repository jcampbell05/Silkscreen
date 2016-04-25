//
//  CollectionType.swift
//  Silkscreen
//
//  Created by James Campbell on 4/25/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation

extension Frozen where T: CollectionType {
    
    var count: T.Index.Distance {
        return value.count
    }
}