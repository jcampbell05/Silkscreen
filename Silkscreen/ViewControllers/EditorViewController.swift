//
//  EditorViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/22/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

// - Built in Picture in Picture == More Real Estate ?
class EditorViewController: DividableViewController {
    
    let editorContext = EditorContext()
    
    lazy var contentAreaViewController: DividableViewController = {
        let viewController = DividableViewController(arrangedSubviewControllers: [self.assetsNavigationViewController, self.previewViewController])
        viewController.axis = .Horizontal
        return viewController
    }()
    
    let assetsViewController = AssetsViewController()
    let previewViewController = PreviewViewController()
    
    lazy var assetsNavigationViewController: UINavigationController = {
        return UINavigationController(rootViewController: self.assetsViewController)
    }()
    
    lazy var timelineNavigationController: UINavigationController = {
        return UINavigationController(rootViewController: self.timelineViewController)
    }()
    
    let timelineViewController = TimelineViewController()
    
    init() {
        super.init()
        
        addArrangedChildViewController(contentAreaViewController)
        addArrangedChildViewController(timelineNavigationController)
        
        contentAreaViewController.view.heightAnchor.constraintEqualToAnchor(view.heightAnchor, multiplier: 0.45, constant: 0.0).active = true
        assetsNavigationViewController.view.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.5, constant: 0.0).active = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        assetsViewController.editorContext = editorContext
        previewViewController.editorContext = editorContext
        timelineViewController.editorContext = editorContext
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
    
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
