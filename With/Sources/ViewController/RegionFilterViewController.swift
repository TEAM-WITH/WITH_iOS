//
//  RegionFilterViewController.swift
//  With
//
//  Created by JUNE on 2019/12/26.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class RegionFilterViewController: UIViewController {
    @IBOutlet weak var regionCollectionView: UICollectionView!
    @IBOutlet weak var semiRegionCollectionView: UICollectionView!
    @IBOutlet weak var countryTableView: UITableView!
    //var countryList: [Country]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
//        setCountryData()
//        countryTableView.reloadData()
//        self.countryTableView.dataSource = self
        self.regionCollectionView.dataSource = self
        self.semiRegionCollectionView.dataSource = self
    }

}
extension RegionFilterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == regionCollectionView {
                 return 6
             }else if collectionView == semiRegionCollectionView {
                 return 3
        }else if collectionView == countryTableView {
                 return 24
        }
            return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == regionCollectionView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegionCell", for: indexPath) as! RegionCollectionViewCell
            return cell
        }else if collectionView == semiRegionCollectionView{
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SemiRegionCell", for: indexPath) as! SemiRegionCollectionViewCell
        return cell
     }
    //else if collectionView == countryTableView{
//        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryCell", for: indexPath) as! countryTableView
//        return cell
       // }
        return UICollectionViewCell()
    }
}
extension RegionFilterViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //destination view controller
//        let dvc = storyboard?.instantiateViewController(withIdentifier: "CountryTableViewController")as! CountryTableViewController
//        let country = countryList[indexPath.row]
//        dvc.albumImg = music.albumImg
//        dvc.musicTitle = music.musicTitle
//        dvc.singer = music.singer
//        navigationController?.pushViewController(dvc, animated: true)
    }
}


extension RegionFilterViewController {
//    func setCountryData() {
//        let country1 = Country(title: "그리스", Image: "countryImg")
//        let country2 = Country(title: "그리스", Image: "countryImg")
//        let country3 = Country(title: "그리스", Image: "countryImg")
//        let country4 = Country(title: "그리스", Image: "countryImg")
//        let country5 = Country(title: "그리스", Image: "countryImg")
//        let country6 = Country(title: "그리스", Image: "countryImg")
//        let country7 = Country(title: "그리스", Image: "countryImg")
//        let country8 = Country(title: "그리스", Image: "countryImg")
//        let country9 = Country(title: "그리스", Image: "countryImg")
//        let country10 = Country(title: "그리스", Image: "countryImg")
//        let country11 = Country(title: "그리스", Image: "countryImg")
//        let country12 = Country(title: "그리스", Image: "countryImg")
//        let country13 = Country(title: "그리스", Image: "countryImg")
//        let country14 = Country(title: "그리스", Image: "countryImg")
//        let country15 = Country(title: "그리스", Image: "countryImg")
//        let country16 = Country(title: "그리스", Image: "countryImg")
//        let country17 = Country(title: "그리스", Image: "countryImg")
//        let country18 = Country(title: "그리스", Image: "countryImg")
//        let country19 = Country(title: "그리스", Image: "countryImg")
//        let country20 = Country(title: "그리스", Image: "countryImg")
//        let country21 = Country(title: "그리스", Image: "countryImg")
//        let country22 = Country(title: "그리스", Image: "countryImg")
//        let country23 = Country(title: "그리스", Image: "countryImg")
//        let country24 = Country(title: "그리스", Image: "countryImg")
//
//
//        // 생성한 musicList 배열에 Music 모델들을 저장합니다.
//        countryList = [country1, country2, country3, country4, country5, country6, country7, country8, country9, country10,country11,country12,country13,country14,country15,country16,country17,country18,country19,country20,country21,country22,country23,country24]
//    }
}
