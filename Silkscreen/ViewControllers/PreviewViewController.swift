//
//  PreviewViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/22/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
    
    lazy var viewFullscreenButton: UIBarButtonItem = {
       return UIBarButtonItem(barButtonSystemItem: .Play, target: self, action: #selector(didPressViewFullscreen))
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        toolbarItems = [
            viewFullscreenButton
        ]
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.setToolbarHidden(false, animated: animated)
    }
    
    @objc private func didPressViewFullscreen() {
        
        let viewController = FullscreenPreviewViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.transitioningDelegate = self
        
        presentViewController(navigationController, animated: true, completion: nil)
    }
}
