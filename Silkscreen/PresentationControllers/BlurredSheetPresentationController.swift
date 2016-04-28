//
//  BlurredSheetPresentationController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/28/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class BlurredSheetPresentationController: UIPresentationController {
    
    let blurringView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
    
    override func presentationTransitionWillBegin() {
        
        super.presentationTransitionWillBegin()
        
        guard let containerView = containerView else {
            return
        }
        
        blurringView.frame = containerView.bounds
        containerView.addSubview(blurringView)
    }
    
    override func presentationTransitionDidEnd(completed: Bool) {
        
        super.presentationTransitionDidEnd(completed)
        
        if !completed {
            blurringView.removeFromSuperview()
        }
    }

    override func dismissalTransitionWillBegin() {
        
        super.dismissalTransitionWillBegin()
        
    }
    
    override func dismissalTransitionDidEnd(completed: Bool) {
        
        super.dismissalTransitionDidEnd(completed)
        
        if completed {
            blurringView.removeFromSuperview()
        }
    }
    
}