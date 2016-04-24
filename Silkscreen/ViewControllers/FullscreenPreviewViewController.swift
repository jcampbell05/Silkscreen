//
//  FullscreenPreviewViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/23/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class FullscreenPreviewViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blackColor()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}