//
//  AddAssetViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/28/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class AddAssetViewController: UISplitViewController {
    
    let imagePickerViewController = ImagePickerViewController()
    
    var editorContext: EditorContext? = nil {
        didSet {
            imagePickerViewController.editorContext = editorContext
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = [UIViewController(), imagePickerViewController]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}