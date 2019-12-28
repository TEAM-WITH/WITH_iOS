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
        self.countryTableView.dataSource = self
        self.countryTableView.delegate = self
        self.regionCollectionView.dataSource = self
        self.regionCollectionView.delegate = self
        self.semiRegionCollectionView.dataSource = self
    }

}

extension RegionFilterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == regionCollectionView {
                 return 6
             }else if collectionView == semiRegionCollectionView {
                 return 10
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
    
    func semicollectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == semiRegionCollectionView {
        let cell = collectionView.cellForItem(at: indexPath) as! SemiRegionCollectionViewCell
       // cell.semiRegionBtn.textColor = UIColor.black
        }
    }
}
extension RegionFilterViewController: UICollectionViewDelegate {
    // 선택될때
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == regionCollectionView {
        let cell = collectionView.cellForItem(at: indexPath) as! RegionCollectionViewCell
        cell.regionLabel.textColor = UIColor.black
        cell.regionLine.backgroundColor = UIColor.orange
        cell.regionLine.isHidden = false

            
        }}
    // 선택안될때
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == regionCollectionView {
        let cell = collectionView.cellForItem(at: indexPath) as! RegionCollectionViewCell
        cell.regionLabel.textColor = UIColor.lightGray
        cell.regionLine.isHidden = true
        }else {
            semicollectionView(collectionView, didSelectItemAt: indexPath)
        }
    }
    
    // 선택안될때
    func semicollectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == semiRegionCollectionView {
        let cell = collectionView.cellForItem(at: indexPath) as! SemiRegionCollectionViewCell
 //       cell.semiRegionBtn.textColor = UIColor.orange
}
    }
        }

extension RegionFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == countryTableView {
            return 4
        }
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = countryTableView.dequeueReusableCell(withIdentifier: "CountryCell") as! CountryCellTableViewCell
       return cell
  }
}

extension RegionFilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        destination view controller
//        let dvc = storyboard?.instantiateViewController(withIdentifier: "CountryTableViewController")as! CountryTableViewController
//
//        navigationController?.pushViewController(dvc, animated: true)
    }
}
