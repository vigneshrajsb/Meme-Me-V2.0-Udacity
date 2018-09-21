//
//  UIViewExtension.swift
//  Meme Me V2.0
//
//  Created by Vigneshraj Sekar Babu on 9/20/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func createShadow() {
        layer.masksToBounds = false
        layer.shadowColor = customBlue.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 3
        layer.shadowOffset = CGSize.zero
      
        
        layer.shouldRasterize = true
        
    }
    
}
