//
//  ListViewController.swift
//  Meme Me V2.0
//
//  Created by Vigneshraj Sekar Babu on 9/13/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

var savedMemes: [Meme] = []
var results: Results<MemeMe> = {
    let realm = try! Realm()
    let results = realm.objects(MemeMe.self).sorted(byKeyPath: "dateSaved", ascending: false)
    return results
}()

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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memeList.reloadData()
        assignHeightValue(for: constraintTopViewHeight)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
      
        guard tabBarController?.selectedIndex == 0 else { return }
        assignHeightValue(for: constraintTopViewHeight)
    }
    

    func initializeUI() {
        topView.backgroundColor = customBlue
        
        if  let navigationController = navigationController  {
            removeNavBarBorder(for: navigationController)
           
        }
        if let titleImage = UIImage(named: "title"){
            let imgView = UIImageView(image: titleImage)
            imgView.contentMode = .scaleAspectFit
           self.navigationItem.titleView = imgView
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
                detailVC.selectedMeme = sender as? MemeMe
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
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = memeList.dequeueReusableCell(withIdentifier: "tableCell") as? MemeTableViewCell {
            let meme = results[indexPath.row]
            cell.memeImageView.image = UIImage(data: meme.memedImage)
            cell.memeTextLabel.text = "\(meme.topText) - \(meme.bottomText)"
            cell.dateLabel.text = getDayFrom(date: meme.dateSaved)
            cell.monthLabel.text = getMonthString(date: meme.dateSaved)
            cell.yearLabel.text = getYearFrom(date: meme.dateSaved)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
        performSegue(withIdentifier: segueToDetailFromTable, sender: results[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return constraintTopViewHeight.constant 
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            let alert = UIAlertController(title: "Delete Meme", message: "Are you sure you want to delete this Meme?", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                let realm = try! Realm()
                try! realm.write {
                    realm.delete(results[indexPath.row])
                }
                  self.memeList.reloadData()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) 
            
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
            
          
          
        }
    }
    
}
