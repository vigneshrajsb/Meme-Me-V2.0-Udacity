//
//  AppDelegate.swift
//  Meme Me V2.0
//
//  Created by Vigneshraj Sekar Babu on 9/10/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch
        if UserDefaults.standard.bool(forKey: "HasLaunchedOnce") {
            //if not application's first launch then launch Tab Bar controller as setup in Main Storyboard
                 UserDefaults.standard.set(false, forKey: "HasLaunchedOnce")
        } else {
            //load the Getting Started View controller
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let tipsStoryboard = UIStoryboard(name: "Tips", bundle: nil)
            let viewController = tipsStoryboard.instantiateViewController(withIdentifier: "Tips")
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
        }
        return true
    }

}

