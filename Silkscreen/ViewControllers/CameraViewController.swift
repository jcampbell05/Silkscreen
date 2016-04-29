//
//  CameraViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/29/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class CameraViewController: DividableViewController {
    
    private let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController.sourceType = .Camera
        
        addArrangedChildViewController(imagePickerController)
    }
}