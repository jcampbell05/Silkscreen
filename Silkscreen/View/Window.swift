//
//  Window.swift
//  Silkscreen
//
//  Created by James Campbell on 10/31/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit
import ObjectiveC

// - Implement Dragged Events for Drag Source and Drop Targets
// - Can we re-engineer this stuff to be composite so we don't force user to use this subclass ?
class Window: UIWindow, UIGestureRecognizerDelegate {
    
    private lazy var dragGestureRecognizer: UIPanGestureRecognizer = {
        return UIPanGestureRecognizer(target:self, action:#selector(dragGestureRecognizerDidUpdate))
    }()
    
    private lazy var longPressRecognizer: UILongPressGestureRecognizer = {
        return UILongPressGestureRecognizer(target:self, action:#selector(longPressRecognizerDidUpdate))
    }()
    
    private var compositeImageView: UIImageView?
    private var draggingSession: DraggingSession?

    private var lastDraggingDestination: DraggingDestination?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dragGestureRecognizer.delegate = self
        longPressRecognizer.delegate = self
        
        addGestureRecognizer(dragGestureRecognizer)
        addGestureRecognizer(longPressRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginDraggingSession(session: DraggingSession, forView: UIView) {
        
        // - Implement Nice Beginning Animation.
        
        draggingSession = session
        
        let imageView = UIImageView(image: session.compositeImageCache)
        
        imageView.frame = CGRectOffset(imageView.frame, session.offset.x - CGRectGetMidX(imageView.frame), session.offset.y + CGRectGetMidY(imageView.frame))
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowColor = UIColor.blackColor().CGColor
        imageView.layer.shadowOpacity = 0.8
        imageView.layer.shadowOffset = CGSizeMake(0, 3)
        
        addSubview(imageView)
        
        compositeImageView = imageView
    }

    @objc func dragGestureRecognizerDidUpdate(dragGestureRecognizer: UIPanGestureRecognizer) {
        
        // - Implement Animation back to original location
        
        if draggingSession != nil {
        
            let translation = dragGestureRecognizer.translationInView(self)
            compositeImageView?.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, translation.x, translation.y)
        
            let location = dragGestureRecognizer.locationInView(rootViewController?.view)
            updateDraggingDestination(location)
        }
        
        if dragGestureRecognizer.state == .Failed || dragGestureRecognizer.state == .Ended || dragGestureRecognizer.state == .Cancelled {
            endDraggingSession()
        }
    }
    
    @objc func longPressRecognizerDidUpdate(longPressRecognizer: UILongPressGestureRecognizer) {
        
        // - Implement Animation back to original location
        
        if draggingSession != nil {
            
            let location = longPressRecognizer.locationInView(rootViewController?.view)
            updateDraggingDestination(location)
        }
        
        if dragGestureRecognizer.state == .Failed || dragGestureRecognizer.state == .Ended || dragGestureRecognizer.state == .Cancelled {
            endDraggingSession()
        }
    }
    
    private func updateDraggingDestination(location: CGPoint) {
        
        let draggingDestination = rootViewController?.findDraggingDestinationAtPoint(location)
        
        let lastDestinationViewController = lastDraggingDestination as? UIViewController
        let draggingDestinationViewController = rootViewController?.findDraggingDestinationAtPoint(location) as? UIViewController
        guard let localLocation = draggingDestinationViewController?.view.convertPoint(location, fromView: self) else {
            return
        }
        
        if draggingDestinationViewController != lastDestinationViewController {
            lastDraggingDestination?.draggingExited(nil)
            draggingDestination?.draggingEntered(DraggingInfo(point: localLocation))
        }
        
        draggingDestination?.draggingUpdated(DraggingInfo(point: localLocation))
        
        lastDraggingDestination = draggingDestination
    }
    
    private func endDraggingSession() {
        
        lastDraggingDestination?.draggingExited(nil)
        lastDraggingDestination = nil
        
        compositeImageView?.removeFromSuperview()
        compositeImageView = nil
        
        draggingSession = nil
    }
    
    // - <UIGestureRecognizerDelegate>
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
