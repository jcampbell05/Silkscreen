//
//  AssetSourceViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/29/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

// - Rename to AssetImportSourcePickerViewController
class AssetSourceViewController: UITableViewController {
    
    var sources: [AssetImportSource] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var selectedSource: AssetImportSource? {
        didSet {
            let index = 0
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            tableView?.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: .None)
            
            selectedSourceDidChangeSignal.trigger()
        }
    }
    
    private(set) lazy var selectedSourceDidChangeSignal: Signal<AssetSourceViewController> = {
        return Signal(sender: self)
    }()
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if let navigationBarFrame = navigationController?.navigationBar.frame {
            tableView.contentInset = UIEdgeInsetsMake(navigationBarFrame.size.height, 0, 0, 0)
        }
        
        selectedSource = sources.first
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let source = sources[indexPath.row]
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "")
        
        cell.textLabel?.text = source.name
        cell.accessoryType = .DisclosureIndicator
        
        return cell
    }
}