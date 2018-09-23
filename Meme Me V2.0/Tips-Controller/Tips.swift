//
//  Tips.swift
//  Meme Me V2.0
//
//  Created by Vigneshraj Sekar Babu on 9/22/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import Foundation
import UIKit

struct Tips {
    var image: UIImage?
    var text: String
    
    init(image: UIImage, text: String) {
        self.image = image
        self.text = text
    }
    
    func initializeArray() -> [Tips] {
        //
        var tipsArray = [Tips]()
        tipsArray.append(Tips(image: UIImage(named: "tip1") ?? UIImage(), text: "From the Home Tab, Use Album or Camera to get the picture to be Memed"))
        tipsArray.append(Tips(image: UIImage(named: "tip2") ?? UIImage(), text: "From Left to Right \nShare the Meme to social media or save to your phone \n Open text setting \n cancel the current action"))
         tipsArray.append(Tips(image: UIImage(named: "tip3") ?? UIImage(), text: "use the setting pop up to change font, color and border color of the text in the Meme"))
         tipsArray.append(Tips(image: UIImage(named: "tip4") ?? UIImage(), text: "delete the meme by swiping the entry from right to left and choose Delete"))
        return tipsArray
    }
    
}
