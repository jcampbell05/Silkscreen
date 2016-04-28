//
//  AddAssetViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/28/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class AddAssetViewController: UISplitViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = [UIViewController(), UIViewController()]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}