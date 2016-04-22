//
//  EditorViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/22/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class EditorViewController: DividableViewController {
    
    lazy var contentAreaViewController: DividableViewController = {
        let viewController = DividableViewController(arrangedSubviewControllers: [self.assetViewController, self.previewViewController])
        viewController.axis = .Horizontal
        return viewController
    }()
    
    lazy var assetViewController: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor.yellowColor()
        
        return viewController
    }()
    
    lazy var previewViewController: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor.purpleColor()
        
        return viewController
    }()
    
    let timelineViewController = TimelineViewController()
    
    init() {
        super.init()

        addArrangedChildViewController(contentAreaViewController)
        addArrangedChildViewController(timelineViewController)
        
        contentAreaViewController.view.heightAnchor.constraintEqualToAnchor(view.heightAnchor, multiplier: 0.45, constant: 0.0).active = true
        assetViewController.view.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.5, constant: 0.0).active = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}