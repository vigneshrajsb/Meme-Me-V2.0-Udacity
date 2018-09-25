//
//  CustomTextField.swift
//  Meme Me V2.0
//
//  Created by Vigneshraj Sekar Babu on 9/24/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit

//MARK: - Custom Text Field Extension
class CustomTextField: UITextField {
    //to remove the cursor
    override func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }
}
