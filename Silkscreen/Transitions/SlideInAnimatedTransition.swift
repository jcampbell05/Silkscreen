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
        return 0.25
    }
   
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
            return
        }
        guard let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) else {
            return
        }
        
        UIView.animateWithDuration(transitionDuration(transitionContext),
                                   animations: {
            
            // - Make fram off bottom of screen
            fromViewController.view.frame = transitionContext.finalFrameForViewController(fromViewController)
            
        },
                                   completion: {
                                    _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
}