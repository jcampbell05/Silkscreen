//
//  UIView+Drag.swift
//  Silkscreen
//
//  Created by James Campbell on 10/30/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

// - Split these out into other areas.
// - Build well built dragging system that simulates OS X system

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

@objc class DraggingSession: NSObject, UIGestureRecognizerDelegate {
    
    let offset: CGPoint
    let compositeImageCache: UIImage
    
    private init(pasteBoard: UIPasteboard, image: UIImage, offset: CGPoint, source: DraggingSource) {
        
        compositeImageCache = image
        self.offset = offset
        
        super.init()
    }
}

protocol PasteboardWriting {
    
}

protocol DraggingSource {
    
}

extension UIView {
    
    func beginDraggingSession(with items: [DraggingItem],
                                   location: CGPoint,
                                   source: DraggingSource) -> DraggingSession {
        
        guard let window = window as? Window else {
            fatalError("Dragging Session started with view without dragging compatable Window")
        }
        
        guard let item = items.first, let image = item.imageComponents?.first?.contents as? UIImage else {
            fatalError("Dragging Session started without valid components")
        }
        
        let session = DraggingSession(pasteBoard: UIPasteboard.generalPasteboard(), image: image, offset: location, source: source)
        
        window.beginDraggingSession(session, forView:  self)
        
        return session
    }
    
    func register(forDraggedTypes: [String]) {
        
    }
}
