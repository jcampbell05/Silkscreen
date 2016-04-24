//
//  AppDelegate.swift
//  Silkscreen
//
//  Created by James Campbell on 18/01/2016.
//  Copyright © 2016 SK. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = {
        let bounds = UIScreen.mainScreen().bounds
        return UIWindow(frame: bounds)
    }()
    
    let rootViewController: EditorViewController = EditorViewController()
    
    lazy var rootNavigationController: UINavigationController = {
       return UINavigationController(rootViewController: self.rootViewController)
    }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
        
        checkForExternalDisplay()
        
        return true
    }
    
    private func checkForExternalDisplay() {
        
        guard let secondScreen = UIScreen.screens().filter({
            $0 != UIScreen.mainScreen()
        }).first else {
            return
        }
        
        let secondWindow = UIWindow(frame: secondScreen.bounds)
        secondWindow.rootViewController = PreviewViewController()
        secondWindow.screen = secondScreen
        secondWindow.makeKeyAndVisible()
     }
}

