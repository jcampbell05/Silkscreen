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
    /**
     *  Tells the delegate that the user finish picking photos or videos.
     *  @param picker The controller object managing the assets picker interface.
     *  @param assets An array containing picked PHAssets objects.
     */
    func assetsPickerController(_ picker: GMImagePickerController!, didFinishPickingAssets assets: [Any]!) {
        let assets = assets as! [PHAsset]
        
        assets.forEach { asset in
            editorContext.addAsset(asset)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }


    let editorContext = EditorContext()
  
  #if os(iOS) || os(watchOS) || os(tvOS)
    private lazy var addButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressAdd))
    }()
  #endif
  
    fileprivate lazy var contentAreaViewController: DividableViewController = {
        let viewController = DividableViewController(arrangedSubviewControllers: [self.assetsViewController, self.previewViewController])
        viewController.axis = .horizontal
        return viewController
    }()
  
    fileprivate let assetsViewController = AssetsViewController()
    fileprivate let previewViewController = PreviewViewController()
    
    fileprivate lazy var timelineNavigationController: UINavigationController = {
        return UINavigationController(rootViewController: self.timelineViewController)
    }()
    
    fileprivate let timelineViewController = TimelineViewController()
  
    fileprivate lazy var titleField: UITextField = {
      let titleField = UITextField(frame: CGRect(x:0, y:0, width:100, height:40))
      
      #if os(iOS) || os(watchOS) || os(tvOS)
      titleField.returnKeyType = .done
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
      
      
        addArrangedChildViewController(contentAreaViewController)
        addArrangedChildViewController(timelineNavigationController)
        
        contentAreaViewController.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45, constant: 0.0).isActive = true
        assetsViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: 0.0).isActive = true
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    #if os(iOS) || os(watchOS) || os(tvOS)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.barTintColor = UIColor.lightGray
      #endif
    }
  
  #if os(iOS) || os(watchOS) || os(tvOS)
    
//    func prefersStatusBarHidden() -> Bool {
//        return true
//    }
  
  #endif
    
    
    @objc fileprivate func didPressAdd() {
       #if os(iOS) || os(watchOS) || os(tvOS)
        let viewController = GMImagePickerController()
        viewController.delegate = self
        viewController.transitioningDelegate = self
        viewController.modalPresentationStyle = .custom
        
        present(viewController, animated: true, completion: nil)
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
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        let presentationController = presentedViewController?.presentationController as? BlurredSheetPresentationController
        return presentationController?.interactiveDismissTransition
    }
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController?, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        return BlurredSheetPresentationController(presentedViewController: presented, presenting: presenting)
    }
  

    // - <GMImagePickerControllerDelegate>
  
    func assetsPickerControllerDidCancel(_ picker: GMImagePickerController!) {
      picker.dismiss(animated: true, completion: nil)
    }
  
//    func assetsPickerController(picker: GMImagePickerController!, didFinishPickingAssets assets: [AnyObject]!) {
//      
//      let assets = assets as! [PHAsset]
//      
//      assets.forEach { asset in
//        editorContext.addAsset(asset)
//      }
//      
//      picker.dismiss(animated: true, completion: nil)
//    }
  #endif
  
    // - <UITextFieldDelegate>
  #if os(iOS) || os(watchOS) || os(tvOS)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
      textField.endEditing(false)
    
      return false
    }
  #endif
}
