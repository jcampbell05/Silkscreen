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
    var image: UIImage = UIImage()
    
    init(pasteboardWriter: PasteboardWriting){
        
    }
    
    func setDraggingFrame(draggingFrame: CGRect, image: UIImage) {
        self.draggingFrame = draggingFrame
        self.image = image
    }
}
