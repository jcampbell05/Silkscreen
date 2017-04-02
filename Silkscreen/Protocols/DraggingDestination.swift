//
//  DraggingDestination.swift
//  Silkscreen
//
//  Created by James Campbell on 11/1/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation

protocol DraggingDestination {
    
    func shouldAllowDrag(_ draggingInfo: DraggingInfo) -> Bool
    
    func draggingEntered(_ sender: DraggingInfo)
    func draggingUpdated(_ sender: DraggingInfo)
    func draggingEnded(_ sender: DraggingInfo)
    func draggingExited(_ sender: DraggingInfo)
}
