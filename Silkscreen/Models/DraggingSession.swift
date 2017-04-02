//
//  DraggingSession.swift
//  Silkscreen
//
//  Created by James Campbell on 11/1/16.
//  Copyright © 2016 SK. All rights reserved.
//

#if os(iOS) || os(watchOS) || os(tvOS)
    import UIKit
#endif

@objc class DraggingSession: NSObject {
    
    let draggingPasteboard: UIPasteboard
    let offset: CGPoint
    let image: UIImage
    
    init(pasteboard: UIPasteboard, image: UIImage, offset: CGPoint) {
        
        self.draggingPasteboard = pasteboard
        self.image = image
        self.offset = offset
        
        super.init()
    }
}
