//
//  BlurredSheetPresentationController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/28/16.
//  Copyright © 2016 SK. All rights reserved.
//

#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit
#endif

class BlurredSheetPresentationController: UIPresentationController {
    
    private let blurringView: UIVisualEffectView = UIVisualEffectView(effect: nil)
    private lazy var tapGesture: UITapGestureRecognizer = {
       return UITapGestureRecognizer(target: self, action: #selector(didPerformDismissGesture))
    }()
    
    private(set) var interactiveDismissTransition: UIPercentDrivenInteractiveTransition? = nil
    private(set) lazy var blurringViewRadiusAnimator: UIViewPropertyAnimator = {
        
        guard let transitionCoordinator = self.presentedViewController.transitionCoordinator() else {
            fatalError("blurringViewRadiusAnimator used outside of a transition")
        }
        
        return UIViewPropertyAnimator(duration: transitionCoordinator.transitionDuration(), curve: transitionCoordinator.completionCurve()) {
            self.blurringView.effect = UIBlurEffect(style: .Dark)
        }
    }()
    
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
        
        blurringViewRadiusAnimator.startAnimation()
    }
    
    override func presentationTransitionDidEnd(completed: Bool) {
        
        super.presentationTransitionDidEnd(completed)
        
        blurringViewRadiusAnimator.pauseAnimation()
        
        if !completed {
            blurringView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionDidEnd(completed: Bool) {
        
        super.dismissalTransitionDidEnd(completed)
        
        if completed {
            blurringView.removeFromSuperview()
        } else {
            blurringViewRadiusAnimator.pauseAnimation()
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
            blurringViewRadiusAnimator.fractionComplete = 1 - progress
            break
            
        default:
            if (progress > 0.5) {
                blurringViewRadiusAnimator.reversed = true
                interactiveDismissTransition?.finishInteractiveTransition()
            } else {
                interactiveDismissTransition?.cancelInteractiveTransition()
            }
            
            blurringViewRadiusAnimator.startAnimation()
            interactiveDismissTransition = nil
            
            break
        }
    }
    
    @objc private func didPerformDismissGesture() {
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
