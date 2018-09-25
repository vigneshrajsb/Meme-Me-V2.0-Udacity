//
//  TipsViewController.swift
//  Meme Me V2.0
//
//  Created by Vigneshraj Sekar Babu on 9/21/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit

class TipsViewController: UIViewController {
    var tipsArray = [Tips]()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tipsCollection: UICollectionView!
    
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //This view controller will only support Portrait orientation
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipsCollection.delegate = self
        tipsCollection.dataSource = self
        tipsCollection.isPagingEnabled = true
        initalizeTips()
    }
    
    func initalizeTips() {
        let reviewtip = "Thank you for your time in reviewing my MemeMe 2.0 Project. \nI have used the Grading rubric to complete all the items but due to similatities from MemeMe 1.0, i wanted to add my own things to the app and i have change few of the UI elements requested and i hope that will be okay. Hope you like what you see from here!!"
        let tip1 = "From the Home Tab, Use Album or Camera buttons and select the picture to Meme it. Crop the Image to your liking for selecting the section of the picture we need."
        let tip2 = "Tap on the Text to enter your own text to the Meme. \n\nLet your imagination fly!"
        let tip3 = "Once the image is selected, in the Meme Editor use the buttons to do more actions. SHARE button lets you share the Meme directly to the media of your liking. Use SETTINGS to customize the text in the Meme."
        let tip4 = "Choose from a variety of Fonts & Colors to create the Text that you like and the one that suits the Meme image. \n\nMore styles will be added regularly."
        let tip5 = "From the List Tab - use right Swipe to Delete the Meme if you do not want it anymore"
        tipsArray.append(Tips(image: UIImage(named: "reviewTip") ?? UIImage(), text: reviewtip))
        tipsArray.append(Tips(image: UIImage(named: "tip1") ?? UIImage(), text: tip1))
        tipsArray.append(Tips(image: UIImage(named: "tip2") ?? UIImage(), text: tip2))
        tipsArray.append(Tips(image: UIImage(named: "tip3") ?? UIImage(), text: tip3))
        tipsArray.append(Tips(image: UIImage(named: "tip4") ?? UIImage(), text: tip4))
        tipsArray.append(Tips(image: UIImage(named: "tip5") ?? UIImage(), text: tip5))
        
        pageControl.numberOfPages = tipsArray.count
    }
    
    //MARK: - Action methods
    @IBAction func previousTapped(_ sender: Any) {
        guard var index = tipsCollection.indexPathsForVisibleItems.first else { return }
        if index.row > 0 {
            index.row -= 1
            scrollTo(index: index)
        }
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        guard var index = tipsCollection.indexPathsForVisibleItems.first else { return }
        if index.row < tipsArray.count - 1 {
            index.row += 1
            scrollTo(index: index)
        }
    }
    
    func scrollTo(index: IndexPath) {
        tipsCollection.scrollToItem(at: index, at: [.centeredVertically, .centeredHorizontally] , animated: true)
        pageControl.currentPage = index.row
    }
    
    @IBAction func getStartedTapped(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "home")
        appDelegate?.window?.rootViewController = homeVC
        UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
    }
}

//MARK: - Collection View Delegate Methods
extension TipsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tipsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TipCollectionViewCell {
            cell.tipImageView.image = tipsArray[indexPath.row].image
            cell.tipTextView.text = tipsArray[indexPath.row].text
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: tipsCollection.frame.width, height: tipsCollection.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard var index = tipsCollection.indexPathsForVisibleItems.first else { return }
        pageControl.currentPage = index.row
    }
}
