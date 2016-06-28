//
//  CollectionViewAnimatedTransition.swift
//  Silkscreen
//
//  Created by James Campbell on 6/28/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

@objc class CollectionViewAnimatedTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var fromCollectionView: UICollectionView?
    var toCollectionView: UICollectionView?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.25
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        // - Methods for these which trap when nil
        guard let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
            return
        }
        
        guard let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) else {
            return
        }
        
        guard let toCollectionView = toCollectionView else {
            return
        }
        
        guard let fromCollectionView = fromCollectionView else {
            return
        }
        
        transitionContext.addViewForNextViewControllerIfNeeded(transitionContext.isPresenting)
        
        let targetViewController = (transitionContext.isPresenting) ? toViewController : fromViewController
        
        // - Create a snapshot
        let indexPathsForSelectedItems = toCollectionView.indexPathsForSelectedItems() ?? []
        let selectedCells = indexPathsForSelectedItems.map {
            return toCollectionView.cellForItemAtIndexPath($0)
        }
        
        UIView.animateWithDuration(transitionDuration(transitionContext),
                                   animations: {

            },
                           completion: {
                            _ in
                            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
}