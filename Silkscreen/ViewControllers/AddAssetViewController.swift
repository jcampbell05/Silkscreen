//
//  AddAssetViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/28/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

// - Use view model for asset source :)
class AddAssetViewController: DividableViewController {

    private let assetSourcePicker = UISplitViewController()
    private let assetSourceViewController = AssetSourceViewController()
    
    var editorContext: EditorContext? = nil {
        didSet {
            
        }
    }
    
    init() {
        
        super.init()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(didPressCancel))
        title = NSLocalizedString("Import Asset", comment: "")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: #selector(didPressCamera))
        
        self.addArrangedChildViewController(assetSourcePicker)
        
        assetSourceViewController.sources = [
            PhotoLibraryAssetImportSource()
        ]
        
        assetSourceViewController.selectedSourceDidChangeSignal.addSlot {
            
            if let selectedSource = $0.selectedSource {
                let viewController = AssetGroupViewController(assetImportSource: selectedSource)
                self.assetSourcePicker.showDetailViewController(viewController, sender: self)
            }
        }
        
        assetSourcePicker.viewControllers = [assetSourceViewController]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didPressCamera() {
        let viewController = CameraViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func didPressCancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}