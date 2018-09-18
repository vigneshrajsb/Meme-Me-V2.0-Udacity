//
//  CollectionViewController.swift
//  Meme Me V2.0
//
//  Created by Vigneshraj Sekar Babu on 9/13/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var camera: UIButton!
    @IBOutlet weak var album: UIButton!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
    }
    
    func initializeUI() {
        topView.backgroundColor = customBlue
        if let navigationController = navigationController {
            removeNavBarBorder(for: navigationController)
        }
        setupGestures()
        setupImagePicker()
    }
    
    func setupImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
    func setupGestures() {
        let leftToRightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwiped))
        leftToRightSwipe.direction = .right
        self.view.addGestureRecognizer(leftToRightSwipe)
    }
    
    @objc func rightSwiped() {
        tabBarController?.selectedIndex = 0
        tabBarController?.view.layer.add(tabBarAnimation(leftToRight: true), forKey: "revealList")
    }
    
    @IBAction func cameraTapped(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Camera Unavailable", message: "Bummer! On this device you cannot take a picture. Don't Worry you can still choose from Library ", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default) { (action) in
                //
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction  func albumTapped(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        prepareSegueToMemeEditor(for: segue, sender: sender)
    }
}


extension CollectionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            performSegue(withIdentifier: segueFromCollectionView, sender: image)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
