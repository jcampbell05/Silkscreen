//
//  ImagePickerViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/26/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

// - Implement a nicer Image Picker with:
// - 3D Touch
// - Preview
// - Extra Properties
// - Fix Pop View Controller Animation Glitch
// - Multi-select
class ImagePickerViewController: DividableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var editorContext: EditorContext? = nil
    
    private lazy var imageController: UIImagePickerController = {
        
        let imageController = UIImagePickerController()
        imageController.delegate = self
        
        return imageController
    }()
    
    var sourceType: UIImagePickerControllerSourceType = .PhotoLibrary {
        didSet {
            imageController.sourceType = sourceType
        }
    }
    
    init() {
        super.init(arrangedSubviewControllers: [])
        
        addArrangedChildViewController(imageController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- UIImagePickerControllerDelegate

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let url = info[UIImagePickerControllerReferenceURL] as? NSURL {
            editorContext?.addAsset(url)
        }
        
        dismissViewControllerAnimated(true, completion:  nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        dismissViewControllerAnimated(true, completion:  nil)
    }
}