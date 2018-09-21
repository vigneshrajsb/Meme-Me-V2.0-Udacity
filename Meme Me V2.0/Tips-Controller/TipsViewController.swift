//
//  TipsViewController.swift
//  Meme Me V2.0
//
//  Created by Vigneshraj Sekar Babu on 9/21/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit

class TipsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //      if let font = UIFont(name: "PhosphateSolid", size: 30.0) {
        //          navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
        
        //        print("font found")
        //    }
        let attributedString = NSAttributedString(string: "MEME ME", attributes: [NSAttributedString.Key.font: UIFont(name: "PhosphateSolid", size: 30.0)]   )
        titleLabel.attributedText = NSAttributedString(attributedString: attributedString)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
