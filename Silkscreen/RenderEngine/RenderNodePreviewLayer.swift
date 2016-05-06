//
//  RenderNodePreviewLayer.swift
//  Silkscreen
//
//  Created by James Campbell on 5/5/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

// - play audio
// - render to open GL
// - player
class RenderNodePreviewLayer: CALayer {
    
    override init() {
        super.init()
        
        backgroundColor = UIColor.redColor().CGColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}