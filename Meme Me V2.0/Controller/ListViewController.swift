//
//  ListViewController.swift
//  Meme Me V2.0
//
//  Created by Vigneshraj Sekar Babu on 9/13/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit

var savedMemes: [Meme] = []

class ListViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var camera: UIButton!
    @IBOutlet weak var album: UIButton!
    
    @IBOutlet weak var memeList: UITableView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
        createTestDate()
        
    }
    
    func createTestDate() {
        let meme1 = UIImage(named: "meme1")
        let meme2 = UIImage(named: "meme2")
        let meme3 = UIImage(named: "meme3")
        let meme4 = UIImage(named: "meme4")
        
        savedMemes.append(Meme(image: meme1!, topText: "Meme 1 top", bottomText: "Meme 1 bottom", dateSaved: Date(), memedImage: meme1!))
        savedMemes.append(Meme(image: meme2!, topText: "Meme 2 Image", bottomText: "Meme 2 bottom Text", dateSaved: Date(), memedImage: meme2!))
        savedMemes.append(Meme(image: meme3!, topText: "Meme 3 Image", bottomText: "camera bottom Text", dateSaved: Date(), memedImage: meme3!))
        savedMemes.append(Meme(image: meme4!, topText: "album Image", bottomText: "album bottom Text", dateSaved: Date(), memedImage: meme4!))
        
    }
    
    func initializeUI() {
        topView.backgroundColor = customBlue
        if  let navigationController = navigationController  {
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
        let rightToLeftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
        rightToLeftSwipe.direction = .left
        self.view.addGestureRecognizer(rightToLeftSwipe)
    }
    
    @objc func swipedLeft() {
        tabBarController?.selectedIndex = 1
        tabBarController?.view.layer.add(tabBarAnimation(leftToRight: false), forKey: "revealCollection")
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

extension ListViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          imagePicker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
             performSegue(withIdentifier: segueFromTableView, sender: image)
        }
        
      
       
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedMemes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = memeList.dequeueReusableCell(withIdentifier: "tableCell") {
            cell.imageView!.image = savedMemes[indexPath.row].image
            cell.textLabel?.text = savedMemes[indexPath.row].topText
          return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueToDetailFromTable, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
