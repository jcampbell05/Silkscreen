//
//  EditorViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/22/16.
//  Copyright © 2016 SK. All rights reserved.
//

#if os(iOS) || os(watchOS) || os(tvOS)
  import UIKit
  import GMImagePicker
#endif

// - Tweak Colors and Designs to feel "pro"
// - TODO: Extensions for protocols
class EditorViewController: DividableViewController, UIViewControllerTransitioningDelegate, GMImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    let editorContext = EditorContext()
  
  #if os(iOS) || os(watchOS) || os(tvOS)
    private lazy var addButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(didPressAdd))
    }()
  #endif
  
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
      
      #if os(iOS) || os(watchOS) || os(tvOS)
      titleField.returnKeyType = .Done
      titleField.delegate = self
        #endif
      
      return titleField
    }()
  
    init() {
        super.init()
      #if os(iOS) || os(watchOS) || os(tvOS)
        navigationItem.titleView = titleField
        navigationItem.leftBarButtonItem = addButton
        #endif
        titleField.text = NSLocalizedString("Untitled Project", comment: "")
      
//      
//        addArrangedChildViewController(contentAreaViewController)
//        addArrangedChildViewController(timelineNavigationController)
//        
//        contentAreaViewController.view.heightAnchor.constraintEqualToAnchor(view.heightAnchor, multiplier: 0.45, constant: 0.0).active = true
//        assetsViewController.view.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.5, constant: 0.0).active = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        #if os(iOS) || os(watchOS) || os(tvOS)
        assetsViewController.editorContext = editorContext
        previewViewController.editorContext = editorContext
          #endif
        timelineViewController.editorContext = editorContext
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
    #if os(iOS) || os(watchOS) || os(tvOS)
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.tintColor = UIColor.blackColor()
        navigationController?.navigationBar.barTintColor = UIColor.lightGrayColor()
      #endif
    }
  
  #if os(iOS) || os(watchOS) || os(tvOS)
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
  
  #endif
    
    
    @objc private func didPressAdd() {
       #if os(iOS) || os(watchOS) || os(tvOS)
        let viewController = GMImagePickerController()
        viewController.delegate = self
        viewController.transitioningDelegate = self
        viewController.modalPresentationStyle = .Custom
        
        presentViewController(viewController, animated: true, completion: nil)
      #endif
    }
    
    // - <UIViewControllerTransitioningDelegate>
    #if os(iOS) || os(watchOS) || os(tvOS)
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
  

    // - <GMImagePickerControllerDelegate>
  
    func assetsPickerControllerDidCancel(picker: GMImagePickerController!) {
      picker.dismissViewControllerAnimated(true, completion: nil)
    }
  
    func assetsPickerController(picker: GMImagePickerController!, didFinishPickingAssets assets: [AnyObject]!) {
      
      let assets = assets as! [PHAsset]
      
      assets.forEach { asset in
        editorContext.addAsset(asset)
      }
      
      picker.dismissViewControllerAnimated(true, completion: nil)
    }
  #endif
  
    // - <UITextFieldDelegate>
  #if os(iOS) || os(watchOS) || os(tvOS)
    func textFieldShouldReturn(textField: UITextField) -> Bool {
    
      textField.endEditing(false)
    
      return false
    }
  #endif
}
