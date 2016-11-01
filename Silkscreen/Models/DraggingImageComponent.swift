//
//  DraggingImageComponent.swift
//  Silkscreen
//
//  Created by James Campbell on 11/1/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

let DraggingImageComponentIconKey = "DraggingImageComponentIconKey"

class DraggingImageComponent {
    
    var key: String
    var frame: CGRect = .zero
    var contents: Any? = nil
    
    init(key: String) {
        self.key = key
    }
}
