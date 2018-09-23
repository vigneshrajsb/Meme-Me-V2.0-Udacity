//
//  CollectionViewController.swift
//  Meme Me V2.0
//
//  Created by Vigneshraj Sekar Babu on 9/13/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    
    @IBOutlet weak var constraintForTopView: NSLayoutConstraint!
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
        guard  tabBarController?.selectedIndex == 1 else { return }
        setupLayout()
    }
    
    func setupLayout() {
        memeCollectionView.collectionViewLayout.invalidateLayout()
        assignHeightValue(for: constraintForTopView)
        print(constraintForTopView.constant)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memeCollectionView.reloadData()
        setupLayout()
    }
    
    func initializeUI() {
        topView.backgroundColor = customBlue
        if let navigationController = navigationController {
            removeNavBarBorder(for: navigationController)
            if let titleImage = UIImage(named: "title"){
                let imgView = UIImageView(image: titleImage)
                imgView.contentMode = .scaleAspectFit
                self.navigationItem.titleView = imgView
            }
        }
        topView.createShadow()
        setupImagePicker()
    }
    
    func setupImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
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
                detailVC.selectedMeme = sender as? MemeMe
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
        //return savedMemes.count
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? MemeCollectionViewCell {
        //cell.memeImageView.image = savedMemes[indexPath.row].memedImage
            cell.memeImageView.image = UIImage(data: results[indexPath.row].memedImage)
        return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
      //  performSegue(withIdentifier: segueCollectiontoDetail, sender: savedMemes[indexPath.row])
         performSegue(withIdentifier: segueCollectiontoDetail, sender: results[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = self.view.safeAreaLayoutGuide.layoutFrame.width
        
        var cellWidth = UIDevice.current.orientation.isLandscape ? viewWidth/5 : viewWidth/3
        if UIDevice.current.orientation.isFlat {
            cellWidth = UIApplication.shared.statusBarOrientation.isLandscape ? viewWidth/5 : viewWidth/3
        }
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    
}
