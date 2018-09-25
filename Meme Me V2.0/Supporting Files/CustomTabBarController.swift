//
//  CustomTabBarController.swift
//  Meme Me V2.0
//
//  Created by Vigneshraj Sekar Babu on 9/15/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
// Custom tab

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {

    //Setting auto rotate properties for the Tab Bar controller
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.all
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        //setting this on view did load when the application
        if UIDevice.current.orientation.isLandscape {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        }
    }
}
