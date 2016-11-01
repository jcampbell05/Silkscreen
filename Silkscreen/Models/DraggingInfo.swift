//
//  DraggingInfo.swift
//  Silkscreen
//
//  Created by James Campbell on 11/1/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class DraggingInfo {
    
    let draggingLocation: CGPoint
    let destinationWindow: UIWindow
    
    init(draggingLocation: CGPoint, destinationWindow: UIWindow) {
        self.draggingLocation = draggingLocation
        self.destinationWindow = destinationWindow
    }
}
