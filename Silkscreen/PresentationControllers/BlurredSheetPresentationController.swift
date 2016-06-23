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
    
    private(set) var interactiveDismissTransition: UIPercentDrivenInteractiveTransition? = nil
    
    private lazy var panGesture: UIPanGestureRecognizer = {
        return UIPanGestureRecognizer(target: self, action: #selector(panGestureStateDidUpdate))
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
        containerView.addSubview(presentedViewController.view)

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
    
    // - Move this into some kind of interactor object
    @objc private func panGestureStateDidUpdate() {
        
        guard let containerView = containerView else {
            return
        }
        
        let translation = panGesture.translationInView(panGesture.view)
        let progress = translation.y / (panGesture.view?.bounds.height ?? 1.0)
        
        switch panGesture.state {
        case .Began:
            interactiveDismissTransition = UIPercentDrivenInteractiveTransition()
            didPerformDismissGesture()
            break
            
        case .Changed:
            interactiveDismissTransition?.updateInteractiveTransition(progress)
            break
            
        default:
            if (progress > 0.5) {
                interactiveDismissTransition?.finishInteractiveTransition()
            } else {
                interactiveDismissTransition?.cancelInteractiveTransition()
            }
            
            interactiveDismissTransition = nil
            
            break
        }
    }
    
    @objc private func didPerformDismissGesture() {
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}