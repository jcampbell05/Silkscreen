//
//  DraggingItem.swift
//  Silkscreen
//
//  Created by James Campbell on 11/1/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

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
