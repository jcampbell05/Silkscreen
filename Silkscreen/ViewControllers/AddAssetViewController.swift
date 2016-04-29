//
//  AddAssetViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/28/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class AddAssetViewController: DividableViewController {

    private let assetSourcePicker = UISplitViewController()
    
    private let assetSourceViewController = AssetSourceViewController()
    private let imagePickerViewController = UITableViewController()
    
    var editorContext: EditorContext? = nil {
        didSet {
           // imagePickerViewController.editorContext = editorContext
        }
    }
    
    init() {
        
        super.init()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(didPressCancel))
        title = NSLocalizedString("Import Asset", comment: "")
        
        self.addArrangedChildViewController(assetSourcePicker)
        
        assetSourceViewController.sources = [
            PhotoLibraryAssetImportSource()
        ]
        assetSourcePicker.viewControllers = [assetSourceViewController, imagePickerViewController]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didPressCancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}