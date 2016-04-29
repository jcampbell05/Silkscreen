//
//  AssetSourceViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 4/29/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

class AssetSourceViewController: UITableViewController {
    
    let sources = [
        PhotoLibraryAssetImportSource()
    ]
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if let navigationBarFrame = navigationController?.navigationBar.frame {
            tableView.contentInset = UIEdgeInsetsMake(navigationBarFrame.size.height, 0, 0, 0)
        }
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