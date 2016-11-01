//
//  UIView+Drag.swift
//  Silkscreen
//
//  Created by James Campbell on 10/30/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

// - Build well built dragging system that simulates OS X system
// - Implement Pasteboard Stuff
// - Reverse Engineer App Kit
// - Coordinate with UICollectionView drag and drop system
// - Move into seperate sections
// - Break these classes into folders

// - Move to VC
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
}
