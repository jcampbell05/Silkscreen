//
//  AppDelegate.swift
//  Silkscreen MacOS
//
//  Created by James Campbell on 3/26/17.
//  Copyright © 2017 SK. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  @IBOutlet weak var window: NSWindow!

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    
    let controller = UXWindowController()
    
    // Insert code here to initialize your application
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }


}

