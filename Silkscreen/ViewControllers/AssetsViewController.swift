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
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc private func didPressAdd() {

        let viewController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        let fromLibraryAction = UIAlertAction(title: NSLocalizedString("From Library", comment: ""), style: .Default) {
            _ in
            
            let viewController = ImagePickerViewController()
            viewController.sourceType = .PhotoLibrary
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        viewController.addAction(fromLibraryAction)
        viewController.modalPresentationStyle = .Popover
        viewController.popoverPresentationController?.barButtonItem = addButton
        
        presentViewController(viewController, animated: true, completion: nil)
    }
}