//
//  SpreadOutCollectionViewTransition.swift
//  Silkscreen
//
//  Created by James Campbell on 6/28/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

@objc class SpreadOutCollectionViewTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.25
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
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
        targetViewController.view.alpha = (transitionContext.isPresenting) ? 0 : 1
        
         UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
            
                targetViewController.view.alpha = (transitionContext.isPresenting) ? 1 : 0
            
            },
            completion: {
                            _ in
                            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
         })
    }
}