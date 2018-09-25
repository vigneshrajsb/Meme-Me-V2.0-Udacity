//
//  UITextView.swift
//  Meme Me V2.0
//
//  Created by Vigneshraj Sekar Babu on 9/24/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit

//MARK: - TextView Extension
extension UITextView {
    
    override open var contentSize: CGSize {
        didSet {
            var topCorrection = (bounds.size.height - contentSize.height * zoomScale) / 2.0
            topCorrection = max(0, topCorrection)
            contentInset = UIEdgeInsets(top: topCorrection, left: 0, bottom: 0, right: 0)
        }
    }
    
    //Shake Animation
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        let fromPoint = CGPoint(x: center.x - 5 , y: center.y)
        shake.fromValue = NSValue(cgPoint: fromPoint)
        let toPoint = CGPoint(x:  center.x + 5 , y: center.y)
        shake.toValue = NSValue(cgPoint: toPoint)
        layer.add(shake, forKey: nil)
    }
}
