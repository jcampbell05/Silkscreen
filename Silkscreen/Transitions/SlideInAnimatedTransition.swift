//
//  SlideInAnimatedTransition.swift
//  Silkscreen
//
//  Created by James Campbell on 6/1/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

@objc class SlideInAnimatedTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
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
        
        let isPresenting = (fromViewController.presentedViewController != nil)
        let targetViewController = (isPresenting) ? toViewController : fromViewController
        
        if isPresenting {
            targetViewController.view.frame = CGRectOffset(transitionContext.finalFrameForViewController(targetViewController), 0, targetViewController.view.bounds.height)
        }
        
        animateWithContext(transitionContext, isPresenting: isPresenting, animations: {
                                    
                                    let finalFrame = transitionContext.finalFrameForViewController(targetViewController)
                                    let yOffset = isPresenting ? 0 : targetViewController.view.bounds.height
                                    
                                    targetViewController.view.frame = CGRectOffset(finalFrame, 0, yOffset)
            },
                                   completion: {
                                    _ in
                                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
    
    private func animateWithContext(transitionContext: UIViewControllerContextTransitioning, isPresenting: Bool, animations: () -> Void, completion: (Bool) -> Void) {
        
        if (isPresenting) {
            
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