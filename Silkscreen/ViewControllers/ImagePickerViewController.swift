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
class ImagePickerViewController: DividableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    //MARK:- UIImagePickerControllerDelegate

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        navigationController?.popViewControllerAnimated(true)
    }
}