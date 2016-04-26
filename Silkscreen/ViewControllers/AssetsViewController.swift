//
//  AssetsViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/22/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

// - Add Tab Bar
class AssetsViewController: UITableViewController {
    
    lazy var addButton: UIBarButtonItem = {
       return UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(didPressAdd))
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        title = NSLocalizedString("Assets", comment: "")
        navigationItem.leftBarButtonItem = addButton
    }
    
    @objc private func didPressAdd() {
        
        // - Create asset source system
        // - Create previews / icons for sources
        // - Present in way that tabs are hidden
        // - Move hiding the navigation bar into the VC we are about to present as not all need that
        let viewController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        let fromLibraryAction = UIAlertAction(title: NSLocalizedString("From Library", comment: ""), style: .Default) {
            _ in
            
            let viewController = UIImagePickerController()
            let viewControllerContainer = DividableViewController(arrangedSubviewControllers: [viewController])
            
            viewController.sourceType = .PhotoLibrary
            
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            self.navigationController?.pushViewController(viewControllerContainer, animated: true)
        }
        
        viewController.addAction(fromLibraryAction)
        viewController.modalPresentationStyle = .Popover
        viewController.popoverPresentationController?.barButtonItem = addButton
        
        presentViewController(viewController, animated: true, completion: nil)
    }
}