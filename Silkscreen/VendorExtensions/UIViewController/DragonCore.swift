//
//  DragonCore.swift
//  Silkscreen
//
//  Created by James Campbell on 4/28/16.
//  Copyright © 2016 SK. All rights reserved.
//

import CoreDragon
import UIKit

extension UIViewController {
    
    private var dragonController: DragonController {
        return DragonController.sharedController()
    }
    
    func registerDragSource(draggable: UIView, delegate: DragonDelegate) {
        dragonController.registerDragSource(draggable, delegate:delegate)
    }
    
    public func unregisterDragSource(draggable: UIView) {
        dragonController.unregisterDragSource(draggable)
    }
    
    public func registerDropTarget(droppable: UIView, delegate: DragonDropDelegate) {
        dragonController.registerDropTarget(droppable, delegate: delegate)
    }

    public func unregisterDropTarget(droppableOrDelegate: AnyObject) {
       dragonController.unregisterDropTarget(droppableOrDelegate)
    }
}