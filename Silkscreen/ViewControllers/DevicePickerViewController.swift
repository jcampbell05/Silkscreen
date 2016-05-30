//
//  DevicePickerViewController.swift
//  Silkscreen
//
//  Created by James Campbell on 5/29/16.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit
import AVFoundation

// - Handle Updates
// - Select Default
// - Move into view model shared across device picker and camera view controller
// - Add None Option
class DevicePickerViewController: UITableViewController {
    
    private let viewModel: DevicePickerViewModel
    
    init(viewModel: DevicePickerViewModel) {
        
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let deviceCount = CGFloat(viewModel.devices.count)
        let height = tableView.rowHeight * deviceCount
        
        preferredContentSize = CGSize(width: 0, height: height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.devices.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") ?? UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        let device = viewModel.devices[indexPath.row]
        
        cell.textLabel?.text = device.localizedName
        
        if viewModel.selectedDevice == .Some(device) {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        viewModel.selectedDevice = viewModel.devices[indexPath.row]
        tableView.reloadData()
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}