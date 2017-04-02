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
    
    fileprivate let blurringView: UIVisualEffectView = UIVisualEffectView(effect: nil)
    fileprivate lazy var tapGesture: UITapGestureRecognizer = {
       return UITapGestureRecognizer(target: self, action: #selector(didPerformDismissGesture))
    }()
    
    fileprivate(set) var interactiveDismissTransition: UIPercentDrivenInteractiveTransition? = nil
    fileprivate(set) lazy var blurringViewRadiusAnimator: UIViewPropertyAnimator = {
        
        guard let transitionCoordinator = self.presentedViewController.transitionCoordinator else {
            fatalError("blurringViewRadiusAnimator used outside of a transition")
        }
      
      
        return UIViewPropertyAnimator(duration: transitionCoordinator.transitionDuration, curve: transitionCoordinator.completionCurve) {
            self.blurringView.effect = UIBlurEffect(style: .dark)
        }
    }()
    
    fileprivate lazy var panGesture: UIPanGestureRecognizer = {
        return UIPanGestureRecognizer(target: self, action: #selector(panGestureStateDidUpdate))
    }()
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let insets = UIEdgeInsetsMake(100, 100, 100, 100)
        return UIEdgeInsetsInsetRect(super.frameOfPresentedViewInContainerView, insets)
    }
    
//    func frameOfPresentedViewInContainerView() -> CGRect {
//        let insets = UIEdgeInsetsMake(100, 100, 100, 100)
//        return UIEdgeInsetsInsetRect(super.frameOfPresentedViewInContainerView, insets)
//    }
    
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
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        
        super.presentationTransitionDidEnd(completed)
        
        blurringViewRadiusAnimator.pauseAnimation()
        
        if !completed {
            blurringView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        
        super.dismissalTransitionDidEnd(completed)
        
        if completed {
            blurringView.removeFromSuperview()
        } else {
            blurringViewRadiusAnimator.pauseAnimation()
        }
    }
    
    @objc fileprivate func panGestureStateDidUpdate() {
        
        let translation = panGesture.translation(in: panGesture.view)
        let progress = translation.y / (panGesture.view?.bounds.height ?? 1.0)
        
        switch panGesture.state {
        case .began:
            interactiveDismissTransition = UIPercentDrivenInteractiveTransition()
            didPerformDismissGesture()
            break
            
        case .changed:
            interactiveDismissTransition?.update(progress)
            blurringViewRadiusAnimator.fractionComplete = 1 - progress
            break
            
        default:
            if (progress > 0.5) {
                blurringViewRadiusAnimator.isReversed = true
                interactiveDismissTransition?.finish()
            } else {
                interactiveDismissTransition?.cancel()
            }
            
            blurringViewRadiusAnimator.startAnimation()
            interactiveDismissTransition = nil
            
            break
        }
    }
    
    @objc fileprivate func didPerformDismissGesture() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
