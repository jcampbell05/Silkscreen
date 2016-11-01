//
//  UIViewController+DragDestination.swift
//  Silkscreen
//
//  Created by James Campbell on 10/31/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit
import ObjectiveC

private var DraggingAssociationKey: UInt8 = 0

extension UIViewController {
    
    func beginDraggingSession(with items: [DraggingItem],
                                   location: CGPoint,
                                   source: DraggingSource) -> DraggingSession {
        
        guard let window = view.window as? Window else {
            fatalError("Dragging Session started with view without dragging compatable Window")
        }
        
        guard let item = items.first else {
            fatalError("Dragging Session started without any items")
        }
        
        let session = DraggingSession(pasteBoard: UIPasteboard.generalPasteboard(), image: item.image, offset: location, source: source)
        
        window.beginDraggingSession(session)
        
        return session
    }
    
    func findDraggingDestinationAtPoint(point: CGPoint) -> DraggingDestination? {
        
        let inside = view.pointInside(point, withEvent: nil)
        let draggable = (objc_getAssociatedObject(self, &DraggingAssociationKey) as? Bool) ?? false
        
        if (draggable && inside) {
            
            return self as? DraggingDestination
            
        } else {
            
            for viewController in childViewControllers {
                
                let location = view.convertPoint(point, toView: viewController.view)
                
                if let draggingDestination = viewController.findDraggingDestinationAtPoint(location) {
                    return draggingDestination
                }
            }
        }
        
        return nil
    }
    
    func shouldAllowDrag(_ draggingInfo: DraggingInfo) -> Bool {
        return false
    }
    
    func register(forDraggedTypes: [String]) {
        // - Implement Correctly
        objc_setAssociatedObject(self, &DraggingAssociationKey, true, .OBJC_ASSOCIATION_RETAIN)
    }
}
