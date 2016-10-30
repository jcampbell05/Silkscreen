//
//  UIView+Drag.swift
//  Silkscreen
//
//  Created by James Campbell on 10/30/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class DraggingItem {
    
}

class DraggingSession {
}

protocol DraggingSource {
    
}

extension UIView {
    
    func beginDraggingSession(with items: [DraggingItem],
                                   gestureRecognizer: UIGestureRecognizer,
                                   source: DraggingSource) -> DraggingSession {
        return DraggingSession()
    }
    
    func register(forDraggedTypes: [String]) {
        
    }
}
