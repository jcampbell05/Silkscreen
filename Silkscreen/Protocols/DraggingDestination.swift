//
//  DraggingDestination.swift
//  Silkscreen
//
//  Created by James Campbell on 11/1/16.
//  Copyright © 2016 SK. All rights reserved.
//

import Foundation

protocol DraggingDestination {
    
    func draggingEntered(sender: DraggingInfo)
    func draggingUpdated(sender: DraggingInfo)
    func draggingExited(sender: DraggingInfo?)
}
