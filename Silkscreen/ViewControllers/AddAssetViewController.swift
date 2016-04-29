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
        
        title = NSLocalizedString("Import Asset", comment: "")
        
        self.addArrangedChildViewController(assetSourcePicker)
        
        assetSourcePicker.viewControllers = [assetSourceViewController, imagePickerViewController]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}