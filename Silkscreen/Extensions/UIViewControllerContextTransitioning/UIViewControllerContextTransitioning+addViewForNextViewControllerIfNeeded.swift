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
    
    func addViewForNextViewControllerIfNeeded(_ aboveOtherViews: Bool) {
      
      #if os(iOS) || os(watchOS) || os(tvOS)
        guard let toViewController = viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return
        }
        
        guard let fromViewController = viewController(forKey: UITransitionContextViewControllerKey.from) else {
            return
        }
        
        if toViewController.view.superview == nil {
            
            if aboveOtherViews {
                containerView.addSubview(toViewController.view)
            } else {
                containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
            }
        }
      
      #endif
    }
}
