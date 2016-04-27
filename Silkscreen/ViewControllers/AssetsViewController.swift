//
//  AssetsViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/22/16.
//  Copyright © 2016 SK. All rights reserved.
//

import CoreDragon
import MobileCoreServices
import UIKit

// - Add Tab Bar
// - Should we move to Rx over Signal / Slot ?
// - Use Diff
// - Simplify datasource
// - UIDocumentInteractionController Support
class AssetsViewController: UITableViewController, DragonDelegate {
    
    var editorContext: EditorContext? = nil {
        didSet {
            assetsDidChangeSlot = editorContext?.assetsDidChangeSignal.addSlot() {
                self.tableView.reloadData()
            }
        }
    }
    
    private var assetsDidChangeSlot: Slot? = nil
    
    lazy var addButton: UIBarButtonItem = {
       return UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(didPressAdd))
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        title = NSLocalizedString("Assets", comment: "")
        navigationItem.leftBarButtonItem = addButton
        
        tableView.registerClass(AssetTableViewCell.self, forCellReuseIdentifier: String(AssetTableViewCell))
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
            viewController.editorContext = self.editorContext
            viewController.sourceType = .PhotoLibrary
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        viewController.addAction(fromLibraryAction)
        viewController.modalPresentationStyle = .Popover
        viewController.popoverPresentationController?.barButtonItem = addButton
        
        presentViewController(viewController, animated: true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editorContext?.assets.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(AssetTableViewCell), forIndexPath: indexPath)
        
        if let cell = cell as? AssetTableViewCell {
            cell.asset = editorContext?.assets[indexPath.row]
        }
        
        DragonController.sharedController().registerDragSource(cell, delegate:self)
        
        return cell
    }
    
    func beginDragOperation(info: DragonInfo, fromView: UIView) {
        info.pasteboard.setValue("Hey", forPasteboardType:kUTTypePlainText as String)
    }
}