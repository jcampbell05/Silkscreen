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
        #if os(iOS) || os(watchOS) || os(tvOS)
        guard let toViewController = viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return false
        }
        
        guard let fromViewController = viewController(forKey: UITransitionContextViewControllerKey.from) else {
            return false
        }
        
        let isPresentingViewController = (fromViewController.presentedViewController != nil)
        let isPushingViewController = (toViewController.navigationController?.viewControllers.contains(fromViewController) ?? false)
        
        return (isPresentingViewController || isPushingViewController)
        #else
          return true
      #endif
    }
}
