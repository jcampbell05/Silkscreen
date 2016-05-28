//
//  Node.swift
//  Silkscreen
//
//  Created by James Campbell on 5/28/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation

// - Abstract the backing in the future so it works across engines
// - GPUImage
// - The Amazing Audio Engine
protocol Node {
    associatedtype InternalNodeType
}