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

    lazy var mainViewController: DividableViewController = {
        return DividableViewController(arrangedSubviewControllers: [self.contentAreaViewController, self.timelineViewController])
    }()
    
    lazy var contentAreaViewController: DividableViewController = {
        let viewController = DividableViewController(arrangedSubviewControllers: [self.assetViewController, self.previewViewController])
        viewController.axis = .Horizontal
        return viewController
    }()
    
    lazy var assetViewController: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor.yellowColor()
        
        return viewController
    }()
    
    lazy var previewViewController: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor.purpleColor()
        
        return viewController
    }()
    
    let timelineViewController = TimelineViewController()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        if let window = window {
            
            window.rootViewController = mainViewController
            window.makeKeyAndVisible()
            
            contentAreaViewController.view.heightAnchor.constraintEqualToAnchor(window.heightAnchor, multiplier: 0.45, constant: 0.0).active = true
            assetViewController.view.widthAnchor.constraintEqualToAnchor(window.widthAnchor, multiplier: 0.5, constant: 0.0).active = true
        }
        
        return true
    }

}

