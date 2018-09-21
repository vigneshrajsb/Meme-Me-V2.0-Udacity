//
//  CustomTabBarController.swift
//  Meme Me V2.0
//
//  Created by Vigneshraj Sekar Babu on 9/15/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        
//        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
//            return false
//        }
//        
//        if fromView != toView {
//            //If the selected index is less than one, then Table List was selected. As we have only two tabs
//            let directionFlag: Bool = self.selectedIndex < 1 ? false : true
//
//            self.view.layer.add(tabBarAnimation(leftToRight: directionFlag), forKey: "revealCollection")
//        }
//        
//      
//        return true
//    }



}
