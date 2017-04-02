//
//  Window.swift
//  Silkscreen
//
//  Created by James Campbell on 10/31/16.
//  Copyright © 2016 SK. All rights reserved.
//

#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit
#endif
import ObjectiveC

// - BDD
class Window: UIWindow, UIGestureRecognizerDelegate {
    
    fileprivate lazy var dragGestureRecognizer: UIPanGestureRecognizer = {
        return UIPanGestureRecognizer(target:self, action:#selector(dragGestureRecognizerDidUpdate))
    }()
    
    fileprivate lazy var longPressRecognizer: UILongPressGestureRecognizer = {
        return UILongPressGestureRecognizer(target:self, action:#selector(longPressRecognizerDidUpdate))
    }()
    
    fileprivate var draggingImageView: UIImageView?
    fileprivate var draggingSession: DraggingSession?

    fileprivate var lastDraggingDestination: DraggingDestination?
  
  #if os(iOS) || os(watchOS) || os(tvOS)
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
  
  #endif
    
    func beginDraggingSession(_ session: DraggingSession) {
        
        draggingSession = session
        
        let imageView = UIImageView(image: session.image)
      
      #if os(iOS) || os(watchOS) || os(tvOS)
        imageView.frame = imageView.frame.offsetBy(dx: session.offset.x - imageView.frame.midX, dy: session.offset.y + imageView.frame.midY)
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.8
        imageView.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        addSubview(imageView)
        #endif
        draggingImageView = imageView
    }

    @objc func dragGestureRecognizerDidUpdate(_ dragGestureRecognizer: UIPanGestureRecognizer) {
      
      #if os(iOS) || os(watchOS) || os(tvOS)
        let location = dragGestureRecognizer.location(in: rootViewController?.view)
        
        if let draggingSession = draggingSession {
        
            let translation = dragGestureRecognizer.translation(in: self)            
            draggingImageView?.transform = CGAffineTransform.identity.translatedBy(x: translation.x, y: translation.y)
            updateDraggingDestination(location, pasteboard: draggingSession.draggingPasteboard, image: draggingSession.image)
            
            if dragGestureRecognizer.state == .failed || dragGestureRecognizer.state == .ended || dragGestureRecognizer.state == .cancelled {
                endDraggingSession(location, pasteboard: draggingSession.draggingPasteboard, image: draggingSession.image)
            }
        }
      #endif
    }
    
    @objc func longPressRecognizerDidUpdate(_ longPressRecognizer: UILongPressGestureRecognizer) {
      
      #if os(iOS) || os(watchOS) || os(tvOS)
        let location = longPressRecognizer.location(in: rootViewController?.view)
        
        if let draggingSession = draggingSession {
            updateDraggingDestination(location, pasteboard: draggingSession.draggingPasteboard, image: draggingSession.image)
            
            if dragGestureRecognizer.state == .failed || dragGestureRecognizer.state == .ended || dragGestureRecognizer.state == .cancelled {
                endDraggingSession(location, pasteboard: draggingSession.draggingPasteboard, image: draggingSession.image)
            }
        }
      #endif
    }
    
    fileprivate func updateDraggingDestination(_ location: CGPoint, pasteboard: UIPasteboard, image: UIImage) {
      
      #if os(iOS) || os(watchOS) || os(tvOS)
        let info = DraggingInfo(draggingPasteboard: pasteboard, draggingLocation: location, destinationWindow: self, draggingImage: image)
        let draggingDestination = rootViewController?.findDraggingDestinationForDraggingInfo(info)
        
        let lastDestinationViewController = lastDraggingDestination as? UIViewController
        let draggingDestinationViewController = draggingDestination as? UIViewController
        
        if draggingDestinationViewController != lastDestinationViewController {
            lastDraggingDestination?.draggingExited(info)
            draggingDestination?.draggingEntered(info)
        }
        
        draggingDestination?.draggingUpdated(info)
        
        lastDraggingDestination = draggingDestination
      #endif
    }
    
    fileprivate func endDraggingSession(_ location: CGPoint, pasteboard: UIPasteboard, image: UIImage) {
        
        lastDraggingDestination?.draggingEnded(DraggingInfo(draggingPasteboard: pasteboard, draggingLocation: location, destinationWindow: self, draggingImage: image))
        lastDraggingDestination = nil
        
        draggingImageView?.removeFromSuperview()
        draggingImageView = nil
        
        draggingSession = nil
    }
    
    // - <UIGestureRecognizerDelegate>
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
