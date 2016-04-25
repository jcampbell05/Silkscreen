//
//  UtilitesViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/25/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class UtilitesViewController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = [
            AssetsViewController()
        ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}