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
    
    @IBOutlet weak var homeImg: UIImageView!
    @IBOutlet weak var recentLabel: UILabel!
    var mateList: [ChatListResult] = []
    var recommendList: [HomeRecommendTrip] = []
    let originRecommendTopValue: CGFloat = 254
    var recentCollectionViewHeight: CGFloat = 0
    var regionCode = "0"
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollection()
        eventPageControl.numberOfPages = 3
    }
    override func viewWillAppear(_ animated: Bool) {
        setDefaultRequest()
        setMateView()
        setRecentCollectionView()
    }
    @IBAction func withMateButtonClick(_ sender: Any) {
        //처음일시 지역필터화면
        
        //아니면 게시글화면
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "BoardList") else { return }
        self.navigationController?.pushViewController(nextVC, animated: true)
        
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
            
        } else if self.mateList.count > 2 {
            self.recentCollectionViewHeight = 245
            
        } else if !self.mateList.isEmpty {
            self.recentCollectionViewHeight = 115
        }
        
        if self.mateList.isEmpty {
            recentLabel.isHidden = false
        }else {
            recentLabel.isHidden = true
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
    
    // MARK: - 홈 기본설정 통신
    func setDefaultRequest() {
        HomeService.shared.getMainImageRequest { data in
            guard let imgString = data?.regionImgH else {return}
            let imgURL = URL(string: imgString)
            self.homeImg.kf.indicatorType = .activity
            self.homeImg.kf.setImage(with: imgURL, options: [.transition(.fade(0.3)), .cacheOriginalImage])
        }
        
        HomeService.shared.getMainMateRequest { data in
            if let mateData = data {
                self.mateList = mateData
                self.mateCollectionView.reloadData()
            }
        }
        
        HomeService.shared.getMainRecommendRequest(regionCode: regionCode) { data in
            if let recommendData = data {
                self.recommendList = recommendData
                self.recommendCollectionView.reloadData()
            }
            
        }
    }
}
// 개수에 관한 collection
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mateCollectionView {
            return mateList.count
        } else if collectionView == recommendCollectionView {
            return recommendList.count
        } else if collectionView == recentCollectonView {
            return 4
        }
        return 0
    }
    // 다중 collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mateCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MateCell", for: indexPath) as! MateCollectionViewCell
            cell.viewModel = mateList[indexPath.item]
            return cell
        } else if collectionView == recommendCollectionView {
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCell", for: indexPath) as! RecommendCollectionViewCell
            cell.viewModel = recommendList[indexPath.item]
            return cell
        } else if collectionView == recentCollectonView {
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentCell", for: indexPath) as! RecentCollectionViewCell
            return cell
        }
        return UICollectionViewCell()
    }
}
