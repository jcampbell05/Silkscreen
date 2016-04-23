//
//  UIViewControllerTransitioningDelegate.swift
//  Silkscreen
//
//  Created by James Campbell on 4/23/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

extension PreviewViewController: UIViewControllerTransitioningDelegate {
    
    func animatedControllerForPreview() -> UIViewControllerAnimatedTransitioning {
        return AnimatedZoomTransition(sourceView: view)
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animatedControllerForPreview()
    }
    
    @available(iOS 2.0, *)
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animatedControllerForPreview()
    }
}