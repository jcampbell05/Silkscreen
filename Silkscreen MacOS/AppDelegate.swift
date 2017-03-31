//
//  AppDelegate.swift
//  Silkscreen MacOS
//
//  Created by James Campbell on 3/26/17.
//  Copyright © 2017 SK. All rights reserved.
//
// TODO: Embed UXKit

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  
  var rootViewController: EditorViewController!
  var windowController: UXWindowController!

  func applicationDidFinishLaunching(notification: NSNotification) {
    
    rootViewController = EditorViewController()
    windowController = UXWindowController(rootViewController: rootViewController)
    
    windowController.window?.setContentSize(NSSize(width:1000, height:700))
    windowController.showWindow(self)
  }

  func applicationWillTerminate(notification: NSNotification) {
    // Insert code here to tear down your application
  }


}

