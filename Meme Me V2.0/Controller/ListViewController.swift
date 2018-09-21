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
    
    @IBOutlet weak var constraintTopViewHeight: NSLayoutConstraint!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        memeList.reloadData()
        assignHeightValue(for: constraintTopViewHeight)
        print(constraintTopViewHeight.constant)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
      
        guard tabBarController?.selectedIndex == 0 else { return }
        assignHeightValue(for: constraintTopViewHeight)
    }
    
    func createTestDate() {
        let meme1 = UIImage(named: "meme1")
        let meme2 = UIImage(named: "meme2")
        let meme3 = UIImage(named: "meme3")
        let meme4 = UIImage(named: "meme4")
        
        savedMemes.append(Meme(image: meme1!, topText: "Meme 1 top", bottomText: "Meme 1 bottom", dateSaved: Date(), memedImage: meme1!, font: "IMPACT", color: "RED", border: "BLUE"))
           savedMemes.append(Meme(image: meme2!, topText: "Meme 2 Image is a big image that cannot be updated", bottomText: "Meme 2 bottom", dateSaved: Date(), memedImage: meme2!, font: "FUTURA", color: "BLUE", border: "YELLOW"))
        savedMemes.append(Meme(image: meme1!, topText: "Meme 1 top", bottomText: "Meme 1 bottom", dateSaved: Date(), memedImage: meme1!, font: "IMPACT", color: "RED", border: "BLUE"))
        savedMemes.append(Meme(image: meme2!, topText: "Meme 2 Image is a big image that cannot be updated", bottomText: "Meme 2 bottom", dateSaved: Date(), memedImage: meme2!, font: "FUTURA", color: "BLUE", border: "YELLOW"))
        savedMemes.append(Meme(image: meme1!, topText: "Meme 1 top", bottomText: "Meme 1 bottom", dateSaved: Date(), memedImage: meme1!, font: "IMPACT", color: "RED", border: "BLUE"))
        savedMemes.append(Meme(image: meme2!, topText: "Meme 2 Image is a big image that cannot be updated", bottomText: "Meme 2 bottom", dateSaved: Date(), memedImage: meme2!, font: "FUTURA", color: "BLUE", border: "YELLOW"))
        savedMemes.append(Meme(image: meme1!, topText: "Meme 1 top", bottomText: "Meme 1 bottom", dateSaved: Date(), memedImage: meme1!, font: "IMPACT", color: "RED", border: "BLUE"))
        savedMemes.append(Meme(image: meme2!, topText: "Meme 2 Image is a big image that cannot be updated", bottomText: "Meme 2 bottom", dateSaved: Date(), memedImage: meme2!, font: "FUTURA", color: "BLUE", border: "YELLOW"))
        savedMemes.append(Meme(image: meme1!, topText: "Meme 1 top", bottomText: "Meme 1 bottom", dateSaved: Date(), memedImage: meme1!, font: "IMPACT", color: "RED", border: "BLUE"))
        savedMemes.append(Meme(image: meme2!, topText: "Meme 2 Image is a big image that cannot be updated", bottomText: "Meme 2 bottom", dateSaved: Date(), memedImage: meme2!, font: "FUTURA", color: "BLUE", border: "YELLOW"))
        savedMemes.append(Meme(image: meme1!, topText: "Meme 1 top", bottomText: "Meme 1 bottom", dateSaved: Date(), memedImage: meme1!, font: "IMPACT", color: "RED", border: "BLUE"))
        savedMemes.append(Meme(image: meme2!, topText: "Meme 2 Image is a big image that cannot be updated", bottomText: "Meme 2 bottom", dateSaved: Date(), memedImage: meme2!, font: "FUTURA", color: "BLUE", border: "YELLOW"))
        savedMemes.append(Meme(image: meme1!, topText: "Meme 1 top", bottomText: "Meme 1 bottom", dateSaved: Date(), memedImage: meme1!, font: "IMPACT", color: "RED", border: "BLUE"))
        savedMemes.append(Meme(image: meme2!, topText: "Meme 2 Image is a big image that cannot be updated", bottomText: "Meme 2 bottom", dateSaved: Date(), memedImage: meme2!, font: "FUTURA", color: "BLUE", border: "YELLOW"))
        savedMemes.append(Meme(image: meme1!, topText: "Meme 1 top", bottomText: "Meme 1 bottom", dateSaved: Date(), memedImage: meme1!, font: "IMPACT", color: "RED", border: "BLUE"))
        savedMemes.append(Meme(image: meme2!, topText: "Meme 2 Image is a big image that cannot be updated", bottomText: "Meme 2 bottom", dateSaved: Date(), memedImage: meme2!, font: "FUTURA", color: "BLUE", border: "YELLOW"))
        savedMemes.append(Meme(image: meme1!, topText: "Meme 1 top", bottomText: "Meme 1 bottom", dateSaved: Date(), memedImage: meme1!, font: "IMPACT", color: "RED", border: "BLUE"))
        savedMemes.append(Meme(image: meme2!, topText: "Meme 2 Image is a big image that cannot be updated", bottomText: "Meme 2 bottom", dateSaved: Date(), memedImage: meme2!, font: "FUTURA", color: "BLUE", border: "YELLOW"))
        
       
    }
    
    func initializeUI() {
        topView.backgroundColor = customBlue
        if  let navigationController = navigationController  {
            print("in nav block")
            removeNavBarBorder(for: navigationController)
            if let font = UIFont(name: "PhosphateSolid", size: 30.0) {
                navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
                
                print("font found")
//                let viewTest = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 35))
//                viewTest.addSubview(label)
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: navigationController.navigationBar.frame.width, height: navigationController.navigationBar.frame.height))
                label.textAlignment = .center
                label.attributedText = NSAttributedString(string: "MEME ME", attributes: [NSAttributedString.Key.font: UIFont(name: "PhosphateSolid", size: 25.0) ])
                label.textColor = customYellow
              //  navigationController.navigationItem.title = ""
                navigationController.navigationBar.addSubview(label)
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
        if segue.identifier == segueFromTableView {
      prepareSegueToMemeEditor(for: segue, sender: sender)
        } else if segue.identifier == segueToDetailFromTable {
            if let detailVC = segue.destination as? DetailViewController {
                detailVC.selectedMeme = sender as? Meme
            }
            
            
        }
        
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
        
        if let cell = memeList.dequeueReusableCell(withIdentifier: "tableCell") as? MemeTableViewCell {
             let meme = savedMemes[indexPath.row]
            cell.memeImageView.image = meme.memedImage
            cell.memeTextLabel.text = "\(meme.topText) - \(meme.bottomText)"
            cell.dateLabel.text = "18"
            cell.monthLabel.text = "Sep"
            cell.yearLabel.text = "2018"
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueToDetailFromTable, sender: savedMemes[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return constraintTopViewHeight.constant - 20
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            let alert = UIAlertController(title: "Delete Meme", message: "Are you sure you want to delete this Meme?", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                savedMemes.remove(at: indexPath.row)
                  self.memeList.reloadData()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) 
            
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
            
          
          
        }
    }
    
}
