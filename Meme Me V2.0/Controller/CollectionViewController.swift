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
    
    @IBOutlet weak var memeCollectionView: UICollectionView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        memeCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memeCollectionView.reloadData()
    }
    
    func initializeUI() {
        topView.backgroundColor = customBlue
        if let navigationController = navigationController {
            removeNavBarBorder(for: navigationController)
        }
      //  setupGestures()
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
        if segue.identifier == segueFromCollectionView {
            prepareSegueToMemeEditor(for: segue, sender: sender)
        } else if segue.identifier == segueCollectiontoDetail {
            if let detailVC = segue.destination as? DetailViewController {
                detailVC.selectedMeme = sender as? Meme
            }
        }
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

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedMemes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? MemeCollectionViewCell {
        cell.memeImageView.image = savedMemes[indexPath.row].memedImage
        return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        performSegue(withIdentifier: segueCollectiontoDetail, sender: savedMemes[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = self.view.safeAreaLayoutGuide.layoutFrame.width
        
        let cellWidth = UIDevice.current.orientation.isPortrait ? viewWidth/3 : viewWidth/4
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    
}
