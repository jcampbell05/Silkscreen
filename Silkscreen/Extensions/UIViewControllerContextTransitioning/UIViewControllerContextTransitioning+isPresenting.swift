//
//  UIViewControllerContextTransitioning+isPresenting.swift
//  Silkscreen
//
//  Created by James Campbell on 6/28/16.
//  Copyright © 2016 SK. All rights reserved.
//

#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit
#endif

extension UIViewControllerContextTransitioning {
    
    var isPresenting: Bool {
        
        guard let toViewController = viewControllerForKey(UITransitionContextToViewControllerKey) else {
            return false
        }
        
        guard let fromViewController = viewControllerForKey(UITransitionContextFromViewControllerKey) else {
            return false
        }
        
        let isPresentingViewController = (fromViewController.presentedViewController != nil)
        let isPushingViewController = (toViewController.navigationController?.viewControllers.contains(fromViewController) ?? false)
        
        return (isPresentingViewController || isPushingViewController)
    }
}
