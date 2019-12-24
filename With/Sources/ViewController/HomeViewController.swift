//
//  HomeViewController.swift
//  With
//
//  Created by JUNE on 2019/12/24.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
//     var mateArray = []
    @IBOutlet weak var mateCollectionView: UICollectionView!
    @IBOutlet weak var recommendCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollection()
    }
}

extension HomeViewController {
    func setCollection() {
        // mate, recommend datasource
        self.mateCollectionView.dataSource = self
        self.recommendCollectionView.dataSource = self
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
        }else if collectionView == recommendCollectionView {
        }
        return 6
    }
    // 다중 collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mateCollectionView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MateCell", for: indexPath) as! MateCollectionViewCell
            return cell
        }else if collectionView == recommendCollectionView{
       let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCell", for: indexPath) as! RecommendCollectionViewCell
            return cell
        }
        return UICollectionViewCell()
    }
}
