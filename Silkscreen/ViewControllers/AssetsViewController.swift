//
//  AssetsViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/22/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class AssetsViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.purpleColor()
        
        toolbarItems = []
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.setToolbarHidden(false, animated: animated)
    }
}