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
    @IBOutlet weak var recentBoardImg: UIImageView!
    
    
    @IBOutlet weak var homeImg: UIImageView!
    @IBOutlet weak var recentLabel: UILabel!
    var mateList: [ChatListResult] = []
    var recommendList: [HomeRecommendTrip] = []
    var recentList: [HomeRecent] = []
    let dum = HomeRecent(boardIdx: 1, name: "권준", userImg: "userImg", regionName: "프랑스", title: "에펠탑 앞 맥주 마실사람")
    let dum1 = HomeRecent(boardIdx: 2, name: "김은별", userImg: "userImg", regionName: "아랍에미리트", title: "낙타타고 사막 거니실 분??")
    let dum2 = HomeRecent(boardIdx: 3, name: "박형모", userImg: "userImg", regionName: "미국", title: "뉴욕에서 새해 맞을사람~~")
    let dum3 = HomeRecent(boardIdx: 4, name: "김남수", userImg: "userImg", regionName: "뉴질랜드", title: "퀸즈랜드 맥주 마실분~~")
    
    let originRecommendTopValue: CGFloat = 254
    var recentCollectionViewHeight: CGFloat = 0
    var regionCode = "0"
    var boardIdx = "0"
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  self.mateimagimage.layer.cornerRadius = self.mateimagimage.frame.width/2
        setCollection()
        eventPageControl.numberOfPages = 3
        recentList.append(dum)
        recentList.append(dum1)
        recentList.append(dum2)
        recentList.append(dum3)
    }
    override func viewWillAppear(_ animated: Bool) {
        setDefaultRequest()
    }
    @IBAction func withMateButtonClick(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "BoardList")
        //        self.navigationController
        
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
        if self.recentList.count > 4 {
            self.recentCollectionViewHeight = 375
            self.mainScrollView.contentSize = CGSize(width: self.view.frame.width, height: 1500)
        } else if self.recentList.count > 2 {
            self.recentCollectionViewHeight = 245
            self.mainScrollView.contentSize = CGSize(width: self.view.frame.width, height: 1385)
        } else if self.recentList.count >= 0 {
            self.recentCollectionViewHeight = 115
            self.mainScrollView.contentSize = CGSize(width: self.view.frame.width, height: 1270)
        }
        
        if self.recentList.isEmpty {
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
                self.setMateView()
            }
        }
        
        HomeService.shared.getMainRecommendRequest(regionCode: regionCode) { data in
            if let recommendData = data {
                self.recommendList = recommendData
                self.recommendCollectionView.reloadData()
                self.setRecentCollectionView()
            }
            
        }
        //        HomeService.shared.getMainRecentRequest(boardIdx: boardIdx) { data in
        //            if let recentData = data {
        //                self.recentList = recommendData
        //                self.recentCollectonView.reloadData()
        //                self.recentCollectonView()
        //            }
        //        }
    }
}
// 개수에 관한 collection
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mateCollectionView {
            if mateList.count > 6 {
                return 6}
            return mateList.count
        } else if collectionView == recommendCollectionView {
            return recommendList.count
        } else if collectionView == recentCollectonView {
            return recentList.count
            //return 4
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
