//
//  OutputNode.swift
//  Silkscreen
//
//  Created by James Campbell on 5/28/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation

protocol OutputNode: Node {
    
    associatedtype TargetInputNodeType
    
    func addTarget(node: TargetInputNodeType)
}