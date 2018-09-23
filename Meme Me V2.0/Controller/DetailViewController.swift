//
//  DetailViewController.swift
//  Meme Me V2.0
//
//  Created by Vigneshraj Sekar Babu on 9/18/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
     //var selectedMeme: Meme?
    var selectedMeme: MemeMe?
    @IBOutlet weak var constraintImageViewWidth: NSLayoutConstraint!
    @IBOutlet weak var constraintImageViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var memeDetailIimageView: UIImageView!
   

    override func viewDidLoad() {
        super.viewDidLoad()
        memeDetailIimageView.translatesAutoresizingMaskIntoConstraints = false
        initializeUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
          self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setupLayout() {
        if UIDevice.current.orientation.isLandscape {
            print("landscape")
            print( self.view.safeAreaLayoutGuide.layoutFrame.height)
            constraintImageViewWidth.constant = view.safeAreaLayoutGuide.layoutFrame.height
            constraintImageViewHeight.constant = view.safeAreaLayoutGuide.layoutFrame.height
        } else {
            print("portrait")
             print( self.view.safeAreaLayoutGuide.layoutFrame.width)
            constraintImageViewWidth.constant = view.safeAreaLayoutGuide.layoutFrame.width
            constraintImageViewHeight.constant = view.safeAreaLayoutGuide.layoutFrame.width
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
       
    }
    
    override func viewWillLayoutSubviews() {
         setupLayout()
    }
    
    func initializeUI() {
        self.tabBarController?.tabBar.isHidden = true
                setupLayout()
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        self.navigationItem.rightBarButtonItems = [editButton, shareButton]
        
        if let selectedMeme = selectedMeme {
            memeDetailIimageView.image = UIImage(data: selectedMeme.memedImage)
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
                editorVC.memeToEdit = sender as? MemeMe
            }
        }
    }

}
