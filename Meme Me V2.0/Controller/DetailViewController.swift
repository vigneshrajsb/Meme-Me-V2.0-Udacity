//
//  DetailViewController.swift
//  Meme Me V2.0
//
//  Created by Vigneshraj Sekar Babu on 9/18/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
          self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func initializeUI() {
        self.tabBarController?.tabBar.isHidden = true
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        self.navigationItem.rightBarButtonItems = [editButton, shareButton]
    }

    @objc func shareTapped() {
        let activityVC = UIActivityViewController(activityItems: [UIImage(named: "meme1")], applicationActivities: nil)
        present(activityVC, animated: true)
        
        print("share tapped")
    }
  
    @objc func editTapped() {
        print("edit tapped")
        performSegue(withIdentifier: segueDetailToEditor, sender: UIImage(named: "meme1"))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueDetailToEditor {
            if let editorVC = segue.destination as? MemeViewController {
                editorVC.selectedImage = sender as? UIImage
            }
        }
    }

}
