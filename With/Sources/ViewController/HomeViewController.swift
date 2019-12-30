//
//  HomeViewController.swift
//  With
//
//  Created by JUNE on 2019/12/24.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIScrollViewDelegate {
    //     var mateArray = []
    @IBOutlet weak var mateCollectionView: UICollectionView!
    @IBOutlet weak var recommendCollectionView: UICollectionView!
    @IBOutlet weak var recentCollectonView: UICollectionView!
    @IBOutlet weak var eventScrollView: UIScrollView!
    @IBOutlet weak var eventPageControl: UIPageControl!
    @IBOutlet weak var withMateView: UIView!
    @IBOutlet weak var recommendTopLayout: NSLayoutConstraint!
    
    @IBOutlet weak var recentLabel: UILabel!
    let dummy = Mate(img: UIImage(), userName: "hihi")
    var mateList: [Mate] = []
    let originRecommendTopValue: CGFloat = 254
    var recentCollectionViewHeight: CGFloat = 0
    // 임의데이터실험 나중에삭제해두댐
    struct Mate {
        var img: UIImage
        var userName: String
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollection()
        eventPageControl.numberOfPages = 3
        mateList.append(dummy)
    }
    override func viewWillAppear(_ animated: Bool) {
        setMateView()
        setRecentCollectionView()
    }
    func setMateView() {
        if self.mateList.isEmpty {
            self.withMateView.isHidden = true
            self.recommendTopLayout.constant = 50
            self.view.layoutIfNeeded()
        } else {
            self.withMateView.isHidden = false
            self.recommendTopLayout.constant = originRecommendTopValue
            self.view.layoutIfNeeded()
        }
    }
//375, 115, 15
    func setRecentCollectionView() {
        if self.mateList.count > 4 {
            self.recentCollectionViewHeight = 375
            recentLabel.isHighlighted = true
        } else if self.mateList.count > 2 {
            self.recentCollectionViewHeight = 245
            recentLabel.isHighlighted = true
        } else if !self.mateList.isEmpty {
            self.recentCollectionViewHeight = 115
            recentLabel.isHidden = false
    
        }
    self.recentCollectonView.translatesAutoresizingMaskIntoConstraints = false
        self.recentCollectonView.heightAnchor.constraint(equalToConstant: recentCollectionViewHeight).isActive = true
        self.view.layoutIfNeeded()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x/scrollView.frame.width
        self.eventPageControl.currentPage = Int(page)
    }
}
extension HomeViewController {
    func setCollection() {
        // mate, recommend datasource
        self.mateCollectionView.dataSource = self
        self.recommendCollectionView.dataSource = self
        self.recentCollectonView.dataSource = self
    }
}
// 개수에 관한 collection
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //    return mateImage.count
        if collectionView == mateCollectionView {
            //            var count = mateArray.count
            //            if count > 6 {
            //                count = 6
            //            }
            //            return count
            return 6
        } else if collectionView == recommendCollectionView {
            return 6
        } else if collectionView == recentCollectonView {
    
              return mateList.count
        }
        return 0
    }
    // 다중 collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mateCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MateCell", for: indexPath) as! MateCollectionViewCell
            return cell
        } else if collectionView == recommendCollectionView {
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCell", for: indexPath) as! RecommendCollectionViewCell
            return cell
        } else if collectionView == recentCollectonView {
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentCell", for: indexPath) as! RecentCollectionViewCell
            return cell
        }
        return UICollectionViewCell()
    }
}
