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
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
   
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
      
      #if os(iOS) || os(watchOS) || os(tvOS)
        // - Methods for these which trap when nil
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return
        }
        
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
            return
        }
        
        transitionContext.addViewForNextViewControllerIfNeeded(transitionContext.isPresenting)
        
        let targetViewController = (transitionContext.isPresenting) ? toViewController : fromViewController
    
        // - Make Built In
        if transitionContext.isPresenting {
            
            var initialFrame = transitionContext.finalFrame(for: targetViewController)
            initialFrame.origin.y = fromViewController.view.frame.height
                
            targetViewController.view.frame = initialFrame
        }
        
        animateWithContext(transitionContext, animations: {
                                    
                                    let finalFrame = transitionContext.finalFrame(for: targetViewController)
                                    let yOffset = transitionContext.isPresenting ? 0 : targetViewController.view.bounds.height
                                    
                                    targetViewController.view.frame = finalFrame.offsetBy(dx: 0, dy: yOffset)
            },
                                   completion: {
                                    _ in
                                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
      #endif
    }
    
    func animateWithContext(_ transitionContext: UIViewControllerContextTransitioning, animations: @escaping () -> Void, completion: @escaping (Bool) -> Void) {
      
      #if os(iOS) || os(watchOS) || os(tvOS)
        // NOTE: We will use the new property animator in iOS 10 to reverse the presentation animation
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                                   animations: animations,
                                   completion: completion)
      #endif
    }
}
