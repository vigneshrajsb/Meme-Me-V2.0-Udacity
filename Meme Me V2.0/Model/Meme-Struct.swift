//
//  Meme.swift
//  Meme Me V2.0
//
//  Created by Vigneshraj Sekar Babu on 9/16/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import Foundation
import UIKit

//Meme Struct
struct Meme {
    var image: UIImage
    var topText: String
    var bottomText: String
    var dateSaved: Date
    var memedImage: UIImage
    var font: String
    var color: String
    var border: String

    public init(image: UIImage, topText: String, bottomText: String, dateSaved: Date, memedImage: UIImage, font: String, color: String, border: String){
        self.image = image
        self.topText = topText
        self.bottomText = bottomText
        self.dateSaved = dateSaved
        self.memedImage = memedImage
        self.font = font
        self.color = color
        self.border = border
    }
}
