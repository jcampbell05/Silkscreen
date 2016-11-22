//
//  EditorViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/22/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

// - Tweak Colors and Designs to feel "pro"
class EditorViewController: DividableViewController, UIViewControllerTransitioningDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let editorContext = EditorContext()
    
    private lazy var addButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(didPressAdd))
    }()
    
    private lazy var contentAreaViewController: DividableViewController = {
        let viewController = DividableViewController(arrangedSubviewControllers: [self.assetsViewController, self.previewViewController])
        viewController.axis = .Horizontal
        return viewController
    }()
    
    private let assetsViewController = AssetsViewController()
    private let previewViewController = PreviewViewController()
    
    private lazy var timelineNavigationController: UINavigationController = {
        return UINavigationController(rootViewController: self.timelineViewController)
    }()
    
    private let timelineViewController = TimelineViewController()
  
    private lazy var titleField: UITextField = {
      let titleField = UITextField(frame: CGRect(x:0, y:0, width:100, height:40))
      
      return titleField
    }()
  
    init() {
        super.init()
      
        navigationItem.titleView = titleField
        navigationItem.leftBarButtonItem = addButton
        titleField.text = NSLocalizedString("Untitled Project", comment: "")
        
        addArrangedChildViewController(contentAreaViewController)
        addArrangedChildViewController(timelineNavigationController)
        
        contentAreaViewController.view.heightAnchor.constraintEqualToAnchor(view.heightAnchor, multiplier: 0.45, constant: 0.0).active = true
        assetsViewController.view.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.5, constant: 0.0).active = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        assetsViewController.editorContext = editorContext
        previewViewController.editorContext = editorContext
        timelineViewController.editorContext = editorContext
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
    
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.tintColor = UIColor.blackColor()
        navigationController?.navigationBar.barTintColor = UIColor.lightGrayColor()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    @objc private func didPressAdd() {
        
        let viewController = UIImagePickerController()
        viewController.delegate = self
        viewController.transitioningDelegate = self
        viewController.modalPresentationStyle = .Custom
        
        presentViewController(viewController, animated: true, completion: nil)
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
        
        editorContext.addAsset(url)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
