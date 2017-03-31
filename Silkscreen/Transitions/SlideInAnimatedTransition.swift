//
//  SlideInAnimatedTransition.swift
//  Silkscreen
//
//  Created by James Campbell on 6/1/16.
//  Copyright © 2016 SK. All rights reserved.
//

#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit
#endif

@objc class SlideInAnimatedTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.2
    }
   
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
      
      #if os(iOS) || os(watchOS) || os(tvOS)
        // - Methods for these which trap when nil
        guard let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
            return
        }
        
        guard let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) else {
            return
        }
        
        transitionContext.addViewForNextViewControllerIfNeeded(transitionContext.isPresenting)
        
        let targetViewController = (transitionContext.isPresenting) ? toViewController : fromViewController
    
        // - Make Built In
        if transitionContext.isPresenting {
            
            var initialFrame = transitionContext.finalFrameForViewController(targetViewController)
            initialFrame.origin.y = fromViewController.view.frame.height
                
            targetViewController.view.frame = initialFrame
        }
        
        animateWithContext(transitionContext, animations: {
                                    
                                    let finalFrame = transitionContext.finalFrameForViewController(targetViewController)
                                    let yOffset = transitionContext.isPresenting ? 0 : targetViewController.view.bounds.height
                                    
                                    targetViewController.view.frame = CGRectOffset(finalFrame, 0, yOffset)
            },
                                   completion: {
                                    _ in
                                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
      #endif
    }
    
    private func animateWithContext(transitionContext: UIViewControllerContextTransitioning, animations: () -> Void, completion: (Bool) -> Void) {
      
      #if os(iOS) || os(watchOS) || os(tvOS)
        // NOTE: We will use the new property animator in iOS 10 to reverse the presentation animation
        UIView.animateWithDuration(transitionDuration(transitionContext),
                                   animations: animations,
                                   completion: completion)
      #endif
    }
}
