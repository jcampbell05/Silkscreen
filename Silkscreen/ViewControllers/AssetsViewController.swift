//
//  AssetsViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/22/16.
//  Copyright © 2016 SK. All rights reserved.
//

import MobileCoreServices
import UICollectionViewLeftAlignedLayout
import UIKit

// - Use Diff
// - UIDocumentInteractionController Support
// - Zoom in and out
// - Extension for these protocols
// - Can Scrubbing Styled Asset View Controller Be Done In A UICollectionViewController ?
// - Break up into folders
class AssetsViewController: UICollectionViewController, UIViewControllerTransitioningDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, DraggingSource {
    
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
    
    lazy var longPressToDragGestureRecognizer: UILongPressGestureRecognizer = {
        return UILongPressGestureRecognizer(target: self, action: #selector(longPressToDragGestureDidUpdate))
    }()
    
    init() {
        
        let layout = UICollectionViewLeftAlignedLayout()
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSizeMake(200, 100)
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)

        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        title = NSLocalizedString("Assets", comment: "")
        navigationItem.leftBarButtonItem = addButton
        
        collectionView?.addGestureRecognizer(longPressToDragGestureRecognizer)
        collectionView?.registerClass(AssetCollectionViewCell.self, forCellWithReuseIdentifier: String(AssetCollectionViewCell))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc private func longPressToDragGestureDidUpdate(gestureRecognizer: UIGestureRecognizer) {
        
        print(gestureRecognizer.state.rawValue)
        
        guard gestureRecognizer.state == .Began else {
            return
        }
        
        let location = gestureRecognizer.locationInView(collectionView)
        
        guard let indexPath = collectionView?.indexPathForItemAtPoint(location) else {
            return
        }
        
        guard let cell = collectionView?.cellForItemAtIndexPath(indexPath) else {
            return
        }
        
        view.beginDraggingSession(with: [], gestureRecognizer: gestureRecognizer, source: self)
    }
    
    @objc private func didPressAdd() {

        let viewController = UIImagePickerController()
        viewController.delegate = self
        viewController.transitioningDelegate = self
        viewController.modalPresentationStyle = .Custom
        
        presentViewController(viewController, animated: true, completion: nil)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return editorContext?.assets.count ?? 0
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(AssetCollectionViewCell), forIndexPath: indexPath)
        
        if let cell = cell as? AssetCollectionViewCell {
            cell.asset = editorContext?.assets[indexPath.row]
        }
        
        return cell
    }
    
    // - <UIViewControllerTransitioningDelegate>
    
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
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController?, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        return BlurredSheetPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
    // - <UIImagePickerControllerDelegate>
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        guard let url = info[UIImagePickerControllerReferenceURL] as? NSURL else {
            return
        }
        
        editorContext?.addAsset(url)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // - <DraggingSource>
}
