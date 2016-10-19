//
//  UtilitesViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/25/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class UtilitesViewController: UITabBarController {
    
    var editorContext: EditorContext? = nil {
        didSet {
            assetsViewController.editorContext = editorContext
        }
    }
    
    let assetsViewController = AssetsViewController()
    lazy var assetsNavigationViewController: UINavigationController = {
        return UINavigationController(rootViewController: self.assetsViewController)
    }()
    
    let inspectorViewController = InspectorViewController()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = [
            assetsNavigationViewController,
            inspectorViewController
        ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
