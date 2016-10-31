//
//  UIView+Drag.swift
//  Silkscreen
//
//  Created by James Campbell on 10/30/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

// Split these out into other areas.

let DraggingImageComponentIconKey = "DraggingImageComponentIconKey"

class DraggingImageComponent {
    
    var key: String
    var frame: CGRect = .zero
    var contents: Any? = nil
    
    init(key: String) {
        self.key = key
    }
}

class DraggingItem {
    
    var draggingFrame: CGRect = .zero
    var imageComponents: [DraggingImageComponent]? = nil
    
    init(pasteboardWriter: PasteboardWriting){
        
    }
    
    func setDraggingFrame(draggingFrame: CGRect, contents: Any?) {
        self.draggingFrame = draggingFrame
        
        let component = DraggingImageComponent(key: DraggingImageComponentIconKey)
        component.contents = contents
        component.frame = draggingFrame
        
        self.imageComponents = [
            component
        ]
    }
}

class DraggingSession {
}

protocol PasteboardWriting {
    
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
