//
//  AppDelegate.swift
//  Silkscreen
//
//  Created by James Campbell on 18/01/2016.
//  Copyright © 2016 SK. All rights reserved.
//

#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit
#endif

//TODO: Swift 3
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = {
        let bounds = UIScreen.mainScreen().bounds
        return Window(frame: bounds)
    }()
    
    lazy var navigationController: UINavigationController = {
        return UINavigationController(rootViewController: self.rootViewController)
    }()
    
    lazy var rootViewController: EditorViewController = {
       return EditorViewController()
    }()
    
    lazy var rootNavigationController: UINavigationController = {
       return UINavigationController(rootViewController: self.rootViewController)
    }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

