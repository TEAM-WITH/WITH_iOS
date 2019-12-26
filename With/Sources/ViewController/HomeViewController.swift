//
//  HomeViewController.swift
//  With
//
//  Created by JUNE on 2019/12/24.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import CHIPageControl
class HomeViewController: UIViewController,UIScrollViewDelegate {
    //     var mateArray = []
    @IBOutlet weak var mateCollectionView: UICollectionView!
    @IBOutlet weak var recommendCollectionView: UICollectionView!
    @IBOutlet weak var recentCollectonView: UICollectionView!
    @IBOutlet weak var eventScrollView: UIScrollView!
    @IBOutlet weak var eventPageControl: UIPageControl!
    let eventImagesArray = ["1","2","3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollection()
        //   setBanner()
        eventPageControl.numberOfPages = eventImagesArray.count
        for num in 0..<eventImagesArray.count{
            let imageView = UIImageView()
            imageView.contentMode = .scaleToFill
            imageView.image = UIImage(named: eventImagesArray[num])
            let xPos = CGFloat(num)*self.view.bounds.size.width
            imageView.frame = CGRect(x: xPos, y: 0, width: view.frame.size.width, height:eventScrollView.frame.size.height)
            eventScrollView.contentSize.width = view.frame.size.width*CGFloat(num+1)
            eventScrollView.addSubview(imageView)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x/scrollView.frame.width
        eventPageControl.currentPage = Int(page)
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
        }else if collectionView == recommendCollectionView {
            return 6
        }
        else if collectionView == recentCollectonView {
            return 3
        }
        return 0
    }
    // 다중 collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mateCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MateCell", for: indexPath) as! MateCollectionViewCell
            return cell
        }else if collectionView == recommendCollectionView{
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCell", for: indexPath) as! RecommendCollectionViewCell
            return cell
        }else if collectionView == recentCollectonView{
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentCell", for: indexPath) as! RecentCollectionViewCell
            return cell
        }
        return UICollectionViewCell()
    }
    /*
     func setBanner() {
     let banner1 = Banner(bannerName: "mainImage")
     let banner2 = Banner(bannerName: "mainImage02")
     let banner3 = Banner(bannerName: "mainImage03")
     
     appDelegate.bannerList = [banner1, banner2, banner3]
     }*/
}
