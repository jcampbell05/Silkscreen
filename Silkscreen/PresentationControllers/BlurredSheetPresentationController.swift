//
//  BlurredSheetPresentationController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/28/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

// - Fix blur view dissapearing when dismiss gesture is cancelled
class BlurredSheetPresentationController: UIPresentationController {
    
    private let blurringView: UIVisualEffectView = UIVisualEffectView(effect: nil)
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
        blurringView.addGestureRecognizer(tapGesture)
        
        containerView.addGestureRecognizer(panGesture)
        containerView.addSubview(blurringView)        
        containerView.addSubview(presentedViewController.view)
        
        let animator = UIViewPropertyAnimator(duration: 0.2, curve: .EaseInOut) {
            self.blurringView.effect = UIBlurEffect(style: .Dark)
        }
        
        animator.startAnimation()
    }
    
    override func presentationTransitionDidEnd(completed: Bool) {
        
        super.presentationTransitionDidEnd(completed)
        
        if !completed {
            blurringView.removeFromSuperview()
        }
    }

    override func dismissalTransitionWillBegin() {
        
        super.dismissalTransitionWillBegin()
        
        let animator = UIViewPropertyAnimator(duration: 0.2, curve: .EaseInOut) {
            self.blurringView.effect = nil
        }
        
        animator.startAnimation()
    }
    
    override func dismissalTransitionDidEnd(completed: Bool) {
        
        super.dismissalTransitionDidEnd(completed)
        
        if completed {
            blurringView.removeFromSuperview()
        }
    }
    
    @objc private func panGestureStateDidUpdate() {
        
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
