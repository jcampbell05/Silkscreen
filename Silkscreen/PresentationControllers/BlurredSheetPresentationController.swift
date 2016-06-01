//
//  BlurredSheetPresentationController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/28/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class BlurredSheetPresentationController: UIPresentationController {
    
    private let blurringView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
    private lazy var tapGesture: UITapGestureRecognizer = {
       return UITapGestureRecognizer(target: self, action: #selector(didPerformDismissGesture))
    }()
    
    private lazy var panGesture: UIPanGestureRecognizer = {
        return UIPanGestureRecognizer(target: self, action: #selector(didPerformDismissGesture))
    }()
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        let insets = UIEdgeInsetsMake(100, 100, 100, 100)
        return UIEdgeInsetsInsetRect(super.frameOfPresentedViewInContainerView(), insets)
    }
    
    override func presentationTransitionWillBegin() {
        
        super.presentationTransitionWillBegin()
        
        guard let containerView = containerView else {
            return
        }

        blurringView.frame = containerView.bounds
        blurringView.alpha = 0
        blurringView.addGestureRecognizer(tapGesture)
        
        containerView.addGestureRecognizer(panGesture)
        containerView.addSubview(blurringView)
 
        presentingViewController.transitionCoordinator()?.animateAlongsideTransition({ _ in
            
            self.blurringView.alpha = 1.0
            
        }, completion: nil)
    }
    
    override func presentationTransitionDidEnd(completed: Bool) {
        
        super.presentationTransitionDidEnd(completed)
        
        if !completed {
            blurringView.removeFromSuperview()
        }
    }

    override func dismissalTransitionWillBegin() {
        
        super.dismissalTransitionWillBegin()
        
        presentingViewController.transitionCoordinator()?.animateAlongsideTransition({ _ in
            
            self.blurringView.alpha = 0.0
            
        }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(completed: Bool) {
        
        super.dismissalTransitionDidEnd(completed)
        
        if completed {
            blurringView.removeFromSuperview()
        }
    }
    
    @objc private func didPerformDismissGesture() {
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}