//
//  DetailViewController.swift
//  Meme Me V2.0
//
//  Created by Vigneshraj Sekar Babu on 9/18/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var memeDetailIimageView: UIImageView!
    var selectedMeme: Meme?

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
        
        if let selectedMeme = selectedMeme {
            memeDetailIimageView.image = selectedMeme.memedImage
        }
    }

    @objc func shareTapped() {
        guard let imageAToShare = memeDetailIimageView.image else { return }
        let activityVC = UIActivityViewController(activityItems: [imageAToShare], applicationActivities: nil)
        present(activityVC, animated: true)
        
        print("share tapped")
    }
  
    @objc func editTapped() {
        print("edit tapped")
        guard let selectedMeme = selectedMeme else { return }
        performSegue(withIdentifier: segueDetailToEditor, sender: selectedMeme)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueDetailToEditor {
            if let editorVC = segue.destination as? MemeViewController {
                editorVC.memeToEdit = sender as? Meme
            }
        }
    }

}
