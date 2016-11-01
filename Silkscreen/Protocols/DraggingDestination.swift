//
//  DraggingDestination.swift
//  Silkscreen
//
//  Created by James Campbell on 11/1/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation

protocol DraggingDestination {
    
    func shouldAllowDrag(draggingInfo: DraggingInfo) -> Bool
    
    func draggingEntered(sender: DraggingInfo)
    func draggingUpdated(sender: DraggingInfo)
    func draggingEnded(sender: DraggingInfo)
    func draggingExited(sender: DraggingInfo?)
}
