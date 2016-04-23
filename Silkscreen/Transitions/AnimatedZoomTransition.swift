//
//  AnimatedZoomTransition.swift
//  Silkscreen
//
//  Created by James Campbell on 4/23/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class AnimatedZoomTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let sourceView: UIView
    
    init(sourceView: UIView) {
        self.sourceView = sourceView
    }

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.25
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) else {
            transitionContext.cancelInteractiveTransition()
            return
        }
        
        guard let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
            transitionContext.cancelInteractiveTransition()
            return
        }
        
        let isPresenting = (toViewController.presentingViewController != nil)
        let animatedViewController = (isPresenting) ? toViewController : fromViewController
        let containerView = transitionContext.containerView()
        
        guard let sourceRect = containerView?.convertRect(sourceView.frame, fromView: sourceView.superview) else {
            transitionContext.cancelInteractiveTransition()
            return
        }
        
        let initialFrame = (isPresenting) ? sourceRect : transitionContext.initialFrameForViewController(animatedViewController)
        let finalFrame = (isPresenting) ? transitionContext.finalFrameForViewController(animatedViewController) : sourceRect
        
        
        animatedViewController.view.frame = initialFrame
        
        containerView?.addSubview(toViewController.view)
        
        if !isPresenting {
            containerView?.sendSubviewToBack(toViewController.view)
        }
   
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
                animatedViewController.view.frame = finalFrame
        }, completion: {
            if $0 {
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            }
        })
    }
}