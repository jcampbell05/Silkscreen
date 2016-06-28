//
//  AssetsViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/22/16.
//  Copyright © 2016 SK. All rights reserved.
//

import CoreDragon
import MobileCoreServices
import UICollectionViewLeftAlignedLayout
import UIKit

// - Use Diff
// - UIDocumentInteractionController Support
// - Zoom in and out
// - Extension for these protocols
class AssetsViewController: UICollectionViewController, DragonDelegate, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    var editorContext: EditorContext? = nil {
        didSet {
            editorContext?.assetsDidChangeSignal.addSlot() {
                _ in
                self.collectionView?.reloadData()
            }
        }
    }
    
    lazy var addButton: UIBarButtonItem = {
       return UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(didPressAdd))
    }()
    
    init() {
        
        let layout = UICollectionViewLeftAlignedLayout()
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSizeMake(100, 100)

        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        title = NSLocalizedString("Assets", comment: "")
        navigationItem.leftBarButtonItem = addButton
        
        collectionView?.registerClass(AssetCollectionViewCell.self, forCellWithReuseIdentifier: String(AssetCollectionViewCell))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc private func didPressAdd() {

        let viewController = AddAssetViewController()
        viewController.editorContext = editorContext
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.delegate = self
        navigationController.transitioningDelegate = self
        navigationController.modalPresentationStyle = .Custom
        
        presentViewController(navigationController, animated: true, completion: nil)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return editorContext?.assets.count ?? 0
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(AssetCollectionViewCell), forIndexPath: indexPath)
        
        if let cell = cell as? AssetCollectionViewCell {
            cell.asset = editorContext?.assets[indexPath.row]
        }
        
        // - Fix bug with multiple windows in PR to CoreDragon
        // - Add ability to remove highlight.
        registerDragSource(cell, delegate:self)
        
        return cell
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return SlideInAnimatedTransition()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return SlideInAnimatedTransition()
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {

        let presentationController = presentedViewController?.presentationController as? BlurredSheetPresentationController
        return presentationController?.interactiveDismissTransition
    }
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        return BlurredSheetPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
    // - Who is in charge of the animation
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if let fromVC = fromVC as? AddAssetViewController where (toVC as? AssetGroupViewController) != nil  {
            return fromVC.assetGroupsViewController.collectionViewTransition
        }
        
        if let toVC = toVC as? AddAssetViewController where (fromVC as? AssetGroupViewController) != nil {
            return toVC.assetGroupsViewController.collectionViewTransition
        }
        
        return nil
    }
    
    func beginDragOperation(info: DragonInfo, fromView: UIView) {
        info.pasteboard.setValue("Hey", forPasteboardType:kUTTypePlainText as String)
    }
}