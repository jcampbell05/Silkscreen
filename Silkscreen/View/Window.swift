//
//  Window.swift
//  Silkscreen
//
//  Created by James Campbell on 10/31/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

// - Implement Dragged Events for Drag Source and Drop Targets
class Window: UIWindow, UIGestureRecognizerDelegate {
    
    private lazy var dragGestureRecognizer: UIPanGestureRecognizer = {
        return UIPanGestureRecognizer(target:self, action:#selector(dragGestureRecognizerDidUpdate))
    }()
    
    private lazy var longPressRecognizer: UILongPressGestureRecognizer = {
        return UILongPressGestureRecognizer(target:self, action:#selector(longPressRecognizerDidUpdate))
    }()
    
    private var compositeImageView: UIImageView?
    private var draggingSession: DraggingSession?
    
    private var activeTouches: [UITouch] = []
    
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
        
        imageView.frame = CGRectOffset(imageView.frame, session.offset.x - CGRectGetMidX(imageView.frame), session.offset.y - CGRectGetMidY(imageView.frame))
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowColor = UIColor.blackColor().CGColor
        imageView.layer.shadowOpacity = 0.8
        imageView.layer.shadowOffset = CGSizeMake(0, 3)
        
        addSubview(imageView)
        
        compositeImageView = imageView
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        activeTouches.appendContentsOf(touches)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        
        print("")
    }

    @objc func dragGestureRecognizerDidUpdate(dragGestureRecognizer: UIPanGestureRecognizer) {
        let translation = dragGestureRecognizer.translationInView(self)
        compositeImageView?.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, translation.x, translation.y)
    
        // - Implement Animation back to original location
        // - DRY
        if dragGestureRecognizer.state == .Failed || dragGestureRecognizer.state == .Ended || dragGestureRecognizer.state == .Cancelled {
      
            compositeImageView?.removeFromSuperview()
            compositeImageView = nil
            
            draggingSession = nil
        }
    }
    
    @objc func longPressRecognizerDidUpdate(longPressRecognizer: UILongPressGestureRecognizer) {
        
        // - Implement Animation back to original location
        // - DRY
        if dragGestureRecognizer.state == .Failed || dragGestureRecognizer.state == .Ended || dragGestureRecognizer.state == .Cancelled {
            
            compositeImageView?.removeFromSuperview()
            compositeImageView = nil
            
            draggingSession = nil
        }
    }
    
    // - <UIGestureRecognizerDelegate>
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
