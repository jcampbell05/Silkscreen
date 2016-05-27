//
//  Platform.swift
//  Silkscreen
//
//  Created by James Campbell on 5/27/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation

struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}