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
        return 0.5
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
        
        let toFrame = transitionContext.finalFrameForViewController(toViewController)
        
        let containerView = transitionContext.containerView()
        
        guard let fromFrame = containerView?.convertRect(sourceView.frame, fromView: sourceView.superview) else {
            transitionContext.cancelInteractiveTransition()
            return
        }
        
        toViewController.view.frame = fromFrame
        containerView?.addSubview(toViewController.view)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
                toViewController.view.frame = toFrame
        }, completion: {
            if $0 {
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            }
        })
    }
}