//
//  Window.swift
//  Silkscreen
//
//  Created by James Campbell on 10/31/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit
import ObjectiveC

class Window: UIWindow, UIGestureRecognizerDelegate {
    
    private lazy var dragGestureRecognizer: UIPanGestureRecognizer = {
        return UIPanGestureRecognizer(target:self, action:#selector(dragGestureRecognizerDidUpdate))
    }()
    
    private lazy var longPressRecognizer: UILongPressGestureRecognizer = {
        return UILongPressGestureRecognizer(target:self, action:#selector(longPressRecognizerDidUpdate))
    }()
    
    private var draggingImageView: UIImageView?
    private var draggingSession: DraggingSession?

    private var lastDraggingDestination: DraggingDestination?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dragGestureRecognizer.delegate = self
        longPressRecognizer.delegate = self
        
        dragGestureRecognizer.maximumNumberOfTouches = 1
        
        addGestureRecognizer(dragGestureRecognizer)
        addGestureRecognizer(longPressRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginDraggingSession(session: DraggingSession) {
        
        draggingSession = session
        
        let imageView = UIImageView(image: session.image)
        
        imageView.frame = CGRectOffset(imageView.frame, session.offset.x - CGRectGetMidX(imageView.frame), session.offset.y + CGRectGetMidY(imageView.frame))
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowColor = UIColor.blackColor().CGColor
        imageView.layer.shadowOpacity = 0.8
        imageView.layer.shadowOffset = CGSizeMake(0, 3)
        
        addSubview(imageView)
        
        draggingImageView = imageView
    }

    @objc func dragGestureRecognizerDidUpdate(dragGestureRecognizer: UIPanGestureRecognizer) {
        
        let location = dragGestureRecognizer.locationInView(rootViewController?.view)
        
        if draggingSession != nil {
        
            let translation = dragGestureRecognizer.translationInView(self)
            draggingImageView?.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, translation.x, translation.y)
        
            updateDraggingDestination(location)
        }
        
        if dragGestureRecognizer.state == .Failed || dragGestureRecognizer.state == .Ended || dragGestureRecognizer.state == .Cancelled {
            endDraggingSession(location)
        }
    }
    
    @objc func longPressRecognizerDidUpdate(longPressRecognizer: UILongPressGestureRecognizer) {
        
        let location = longPressRecognizer.locationInView(rootViewController?.view)
        
        if draggingSession != nil {
            updateDraggingDestination(location)
        }
        
        if dragGestureRecognizer.state == .Failed || dragGestureRecognizer.state == .Ended || dragGestureRecognizer.state == .Cancelled {
            endDraggingSession(location)
        }
    }
    
    private func updateDraggingDestination(location: CGPoint) {
        
        let draggingDestination = rootViewController?.findDraggingDestinationAtPoint(location)
        
        let lastDestinationViewController = lastDraggingDestination as? UIViewController
        let draggingDestinationViewController = rootViewController?.findDraggingDestinationAtPoint(location) as? UIViewController
        
        let info = DraggingInfo(draggingLocation: location, destinationWindow: self)
        
        if draggingDestinationViewController != lastDestinationViewController {
            lastDraggingDestination?.draggingExited(info)
            draggingDestination?.draggingEntered(info)
        }
        
        draggingDestination?.draggingUpdated(info)
        
        lastDraggingDestination = draggingDestination
    }
    
    private func endDraggingSession(location: CGPoint) {
        
        lastDraggingDestination?.draggingEnded(DraggingInfo(draggingLocation: location, destinationWindow: self))
        lastDraggingDestination = nil
        
        draggingImageView?.removeFromSuperview()
        draggingImageView = nil
        
        draggingSession = nil
    }
    
    // - <UIGestureRecognizerDelegate>
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
