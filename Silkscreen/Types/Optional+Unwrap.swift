//
//  Optional+Unwrap.swift
//  Silkscreen
//
//  Created by James Campbell on 6/10/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation

extension Optional {
    
    func unwrap(_ callback: (_ optionalValue: Wrapped) -> Void) {
        if let optionalValue = self {
            callback(optionalValue)
        }
    }
}
