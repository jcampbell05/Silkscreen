//
//  RenderEngine.swift
//  Silkscreen
//
//  Created by James Campbell on 11/2/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation
import GPUImage

// - With Asset Manager
class RenderEngine: GPUImageFilter {
    
    func render(_ context: EditorContext) {
        
        context.tracks.value.reversed().forEach { track in
            
            let renderTrack = RenderTrack()
            
            renderTrack.addTarget(self)
            renderTrack.render(track)
        }
    }
}
