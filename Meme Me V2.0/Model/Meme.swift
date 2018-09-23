//
//  Meme.swift
//  Meme Me V2.0
//
//  Created by Vigneshraj Sekar Babu on 9/23/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

//Realm Object
class MemeMe: Object {
    @objc dynamic var image: Data = Data()
    @objc dynamic var topText: String = ""
    @objc dynamic var bottomText: String = ""
    @objc dynamic var dateSaved: Date = Date()
    @objc dynamic var memedImage: Data = Data()
    @objc dynamic var font: String = ""
    @objc dynamic var color: String = ""
    @objc dynamic var border: String = ""

}
