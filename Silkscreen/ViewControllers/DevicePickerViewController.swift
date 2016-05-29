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
class DevicePickerViewController: UITableViewController {
    
    private let mediaType: String
    
    private var devices: [AVCaptureDevice] = []
    
    init(mediaType: String) {
        
        self.mediaType = mediaType
        
        super.init(nibName: nil, bundle: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateDevices), name: AVCaptureDeviceWasConnectedNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateDevices), name: AVCaptureDeviceWasDisconnectedNotification, object: nil)
        
        updateDevices()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func updateDevices() {
        devices = AVCaptureDevice.devicesWithMediaType(mediaType) as! [AVCaptureDevice]
        tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") ?? UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        let device = devices[indexPath.row]
        
        cell.textLabel?.text = device.localizedName
        
        return cell
    }
}