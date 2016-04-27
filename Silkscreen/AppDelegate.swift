//
//  AppDelegate.swift
//  Silkscreen
//
//  Created by James Campbell on 18/01/2016.
//  Copyright © 2016 SK. All rights reserved.
//

import CoreDragon
import UIKit

// - Swinject
// - RxSwift
// - Remove need for Slot and Signal
// - Implement ReFlow
// - iOS Drag And Drop System - Reimplement Dragon Drag And Drop (Or Tidy it up)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = {
        let bounds = UIScreen.mainScreen().bounds
        return UIWindow(frame: bounds)
    }()
    
    lazy var rootViewController: EditorViewController = {
       return EditorViewController()
    }()
    
    lazy var rootNavigationController: UINavigationController = {
       return UINavigationController(rootViewController: self.rootViewController)
    }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        if let window = window {
            DragonController.sharedController().enableLongPressDraggingInWindow(window)
        }
        
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

