//
//  Helper.swift
//  Meme Me V2.0
//
//  Created by Vigneshraj Sekar Babu on 9/13/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import Foundation
import UIKit

let customBlue = UIColor(red: 57/255, green: 67/255, blue: 124/255, alpha: 1.0)
let customYellow = UIColor(red: 255/255, green: 244/255, blue: 136/255, alpha: 1.0)

let maxCharactersAllowedForMemeText = 80

let heightForTopViewInPortrait: CGFloat = 100
let heightForTopViewInLandscape: CGFloat = 80


let segueFromTableView = "tableToEditor"
let segueFromCollectionView = "collectionToEditor"
let segueToDetailFromTable = "listToDetail"
let segueDetailToEditor = "detailToEditor"
let segueCollectiontoDetail = "collectionToDetail"


func removeNavBarBorder(for navigationController: UINavigationController) {
    let navBar = navigationController.navigationBar
    navBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    navBar.shadowImage = UIImage()
}


func assignHeightValue(for constraint: NSLayoutConstraint) {
    if UIDevice.current.orientation.isLandscape {
        constraint.constant = heightForTopViewInLandscape
    } else if UIDevice.current.orientation.isFlat {
        constraint.constant =  UIApplication.shared.statusBarOrientation.isLandscape ? heightForTopViewInLandscape : heightForTopViewInPortrait
    } else {
        constraint.constant = heightForTopViewInPortrait
    }
}

func prepareSegueToMemeEditor(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == segueFromTableView || segue.identifier == segueFromCollectionView  {
        guard let destinationVC = segue.destination as? MemeViewController else { return }
        guard let image = sender as? UIImage else { return }
        destinationVC.selectedImage = image
    }
}

func getColorFromString(string: String)-> UIColor {
    var color = UIColor()
    //let colors = ["White","Black","Blue","Red", "Yellow", "Gray"]
    switch string {
    case "WHITE":
        color = UIColor.white
    case "BLACK":
        color = UIColor.black
    case "BLUE":
        color = UIColor.blue
    case "RED":
        color = UIColor.red
    case "YELLOW":
        color = UIColor.yellow
    case "GRAY":
        color = UIColor.gray
    default:
        color = UIColor.black
    }
    
    return color
}

func getMonthString(date: Date) -> String {
    let calendar = Calendar.current
    let monthIndex = calendar.component(.month, from: date) - 1
    let monthArray = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    if monthIndex > 11 {
        return "Err"
    }
    return monthArray[monthIndex]
}

func getYearFrom(date: Date) -> String {
    let calendar = Calendar.current
    return String(calendar.component(.year, from: date))
}

func getDayFrom(date: Date) -> String {
    let calendar = Calendar.current
    return String(calendar.component(.day, from: date))
}

func getFontFromString(string: String) -> UIFont {
    var fontName = ""
    switch string {
    case "IMPACT":
        fontName = "Impact"
    case "HELVETICA":
        fontName = "HelveticaNeue-Medium"
    case "FUTURA":
        fontName = "Futura-Medium"
    case "AVENIRNEXT":
        fontName = "AvenirNext-Medium"
    default:
        fontName = "Impact"
    }
    guard let font = UIFont(name: fontName, size: 30.0) else { return UIFont() }
    return font
}

//MARKS: - TextView Extension
extension UITextView {
    
    override open var contentSize: CGSize {
        didSet {
            var topCorrection = (bounds.size.height - contentSize.height * zoomScale) / 2.0
            topCorrection = max(0, topCorrection)
            contentInset = UIEdgeInsets(top: topCorrection, left: 0, bottom: 0, right: 0)
        }
    }
    
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5 , y: center.y)
        shake.fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x:  center.x + 5 , y: center.y)
        shake.toValue = NSValue(cgPoint: toPoint)
        
        layer.add(shake, forKey: nil
        )
    }
    
}

class customTextField: UITextField {
    override func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }
}




