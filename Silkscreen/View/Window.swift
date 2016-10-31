//
//  Window.swift
//  Silkscreen
//
//  Created by James Campbell on 10/31/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

// - Allow view to swallow touches for current drag gesture.
class Window: UIWindow, UIGestureRecognizerDelegate {
    
    private lazy var dragGestureRecognizer: UIPanGestureRecognizer = {
        return UIPanGestureRecognizer(target:self, action:#selector(dragGestureRecognizerDidUpdate))
    }()
    
    private var compositeImageView: UIImageView?
    private var draggingSession: DraggingSession?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dragGestureRecognizer.delegate = self
        addGestureRecognizer(dragGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginDraggingSession(session: DraggingSession, forView: UIView) {
        
        draggingSession = session
        
        let imageView = UIImageView(image: session.compositeImageCache)
        
        imageView.frame = CGRectOffset(imageView.frame, session.offset.x - CGRectGetMidX(imageView.frame), session.offset.y - CGRectGetMidY(imageView.frame))
        addSubview(imageView)
        
        compositeImageView = imageView
    }

    @objc func dragGestureRecognizerDidUpdate(dragGestureRecognizer: UIPanGestureRecognizer) {
        let translation = dragGestureRecognizer.translationInView(self)
        compositeImageView?.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, translation.x, translation.y)
    
        // - Implement Animation back to original location
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
