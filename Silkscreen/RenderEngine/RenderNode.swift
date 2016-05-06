//
//  RenderNode.swift
//  Silkscreen
//
//  Created by James Campbell on 5/5/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation
import CoreMedia

class RenderNode: NSObject {
    
    // - How do we push the output data ?
    func frameAtTime(time: CMTime) -> Frame {
        return Frame(sampleBuffers: [])
    }
}