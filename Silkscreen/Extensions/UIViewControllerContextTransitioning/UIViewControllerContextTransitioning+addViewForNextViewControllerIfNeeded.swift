//
//  UIViewControllerContextTransitioning+addViewForNextViewControllerIfNeeded.swift
//  Silkscreen
//
//  Created by James Campbell on 6/28/16.
//  Copyright © 2016 SK. All rights reserved.
//

#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit
#endif

extension UIViewControllerContextTransitioning {
    
    func addViewForNextViewControllerIfNeeded(aboveOtherViews: Bool) {
        
        guard let toViewController = viewControllerForKey(UITransitionContextToViewControllerKey) else {
            return
        }
        
        guard let fromViewController = viewControllerForKey(UITransitionContextFromViewControllerKey) else {
            return
        }
        
        if toViewController.view.superview == nil {
            
            if aboveOtherViews {
                containerView().addSubview(toViewController.view)
            } else {
                containerView().insertSubview(toViewController.view, belowSubview: fromViewController.view)
            }
        }
    }
}
