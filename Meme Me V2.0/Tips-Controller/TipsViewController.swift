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
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipsCollection.delegate = self
        tipsCollection.dataSource = self
        tipsCollection.isPagingEnabled = true
       createArray()
    }
    
    func createArray() {
       
        tipsArray.append(Tips(image: UIImage(named: "tip1") ?? UIImage(), text: "From the Home Tab, Use Album or Camera to get the picture to be Memed"))
        tipsArray.append(Tips(image: UIImage(named: "tip2") ?? UIImage(), text: "From Left to Right \nShare the Meme to social media or save to your phone \n Open text setting \n cancel the current action"))
        tipsArray.append(Tips(image: UIImage(named: "tip3") ?? UIImage(), text: "Use the setting pop up to change font, color and border color of the text in the Meme"))
        tipsArray.append(Tips(image: UIImage(named: "tip4") ?? UIImage(), text: "Delete the meme by swiping the entry from right to left and choose Delete"))
    }
    
    
    @IBAction func previousTapped(_ sender: Any) {
        guard var index = tipsCollection.indexPathsForVisibleItems.first else { return }
        print(tipsCollection.indexPathsForVisibleItems.first)
          print(index.row)
        if index.row > 0 {
            print(index.row)
            index.row -= 1
            scrollTo(index: index)
        }
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        guard var index = tipsCollection.indexPathsForVisibleItems.first else { return }
        if index.row < 3 {
        index.row += 1
        scrollTo(index: index)
        }
    }
    
    func scrollTo(index: IndexPath) {
        tipsCollection.scrollToItem(at: index, at: [.centeredVertically, .centeredHorizontally] , animated: true)
        pageControl.currentPage = index.row
    }
    
    
    @IBAction func getStartedTapped(_ sender: Any) {
      
        
        //window = UIWindow(frame: UIScreen.main.bounds)
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "home")
        appDelegate?.window?.rootViewController = homeVC
        
         //UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
        
    }
    
}

extension TipsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
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
