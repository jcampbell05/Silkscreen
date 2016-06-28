//
//  AssetGroupAnimatedTransition.swift
//  Silkscreen
//
//  Created by James Campbell on 6/28/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

@objc class AssetGroupAnimatedTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
            return
        }
        
        guard let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) else {
            return
        }
        
        transitionContext.addViewForNextViewControllerIfNeeded(transitionContext.isPresenting)
        
        let targetViewController = (transitionContext.isPresenting) ? toViewController : fromViewController
        
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
    }
    
    private func animateWithContext(transitionContext: UIViewControllerContextTransitioning, animations: () -> Void, completion: (Bool) -> Void) {
        
        if (transitionContext.isPresenting) {
            
            UIView.animateWithDuration(transitionDuration(transitionContext),
                                       delay: 0,
                                       usingSpringWithDamping: 0.58,
                                       initialSpringVelocity: 0,
                                       options: [],
                                       animations: animations,
                                       completion: completion)
            
        } else {
            
            // NOTE: We will use the new property animator in iOS 10 to reverse the presentation animation
            UIView.animateWithDuration(transitionDuration(transitionContext) / 2,
                                       animations: animations,
                                       completion: completion)
        }
    }
}