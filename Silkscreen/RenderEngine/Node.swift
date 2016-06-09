//
//  Node.swift
//  Silkscreen
//
//  Created by James Campbell on 5/28/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation
import GPUImage

// - Abstract the backing in the future so it works across engines
// - GPUImage
// - The Amazing Audio Engine
protocol Node {
    func addTarget(node: GPUImageInput)
}