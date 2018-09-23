//
//  TipsViewController.swift
//  Meme Me V2.0
//
//  Created by Vigneshraj Sekar Babu on 9/21/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit

class TipsViewController: UIViewController {
    
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
        
    }
    
}

extension TipsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
     
        cell.backgroundColor = customBlue
        return cell
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
