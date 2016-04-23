//
//  FullscreenPreviewViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/23/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class FullscreenPreviewViewController: UIViewController {
    
    lazy var dismissButton: UIBarButtonItem = {
       return UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(didPressDismiss))
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.orangeColor()
        navigationItem.leftBarButtonItem = dismissButton
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc private func didPressDismiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}