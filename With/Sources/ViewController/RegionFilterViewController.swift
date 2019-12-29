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
    let test = ["유럽", "아프리카", "남아메리카", "가나다라마바사"]
    let test1 = ["유럽전체", "동유럽", "북유럽"]
    override func viewDidLoad() {
        super.viewDidLoad()
        //        setCountryData()
        //        countryTableView.reloadData()
        self.countryTableView.dataSource = self
        self.countryTableView.delegate = self
        self.regionCollectionView.dataSource = self
        self.regionCollectionView.delegate = self
        self.semiRegionCollectionView.dataSource = self
        self.semiRegionCollectionView.delegate = self
    }
}

extension RegionFilterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == regionCollectionView {
            return test.count
        } else if collectionView == semiRegionCollectionView {
            return test1.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == regionCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegionCell", for: indexPath) as! RegionCollectionViewCell
            cell.regionLabel.text = test[indexPath.item]
            return cell
        } else if collectionView == semiRegionCollectionView {
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SemiRegionCell", for: indexPath) as! SemiRegionCollectionViewCell
            cell.semiRegionView.layer.borderWidth = 1
            cell.semiRegionView.layer.borderColor = UIColor.orange.cgColor
            cell.semiRegionLabel.text = test1[indexPath.item]
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
            cell.regionLine.frame.size.height = 1
            cell.regionLine.backgroundColor = UIColor.orange
            cell.regionLine.isHidden = false
        } else if collectionView == semiRegionCollectionView {
            let cell = collectionView.cellForItem(at: indexPath) as! SemiRegionCollectionViewCell
            cell.semiRegionView.layer.backgroundColor = UIColor.orange.cgColor
            cell.semiRegionLabel.textColor = UIColor.white
        
        }
    }
    // 선택안될때
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == regionCollectionView {
            let cell = collectionView.cellForItem(at: indexPath) as! RegionCollectionViewCell
            cell.regionLabel.textColor = UIColor.lightGray
            cell.regionLine.isHidden = true
        } else if collectionView == semiRegionCollectionView {
            let cell = collectionView.cellForItem(at: indexPath) as! SemiRegionCollectionViewCell
            
            cell.semiRegionView.layer.backgroundColor = UIColor.white.cgColor
            cell.semiRegionLabel.textColor = UIColor.orange
           
        }
    }
}

extension RegionFilterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == regionCollectionView {
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        let estimatedSize = NSString(string: test[indexPath.item] ?? "").size(withAttributes: attributes)
            return CGSize(width: estimatedSize.width+2, height: 44)
        } else if collectionView == semiRegionCollectionView {
            let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
            let estimatedSize = NSString(string: test1[indexPath.item] ?? "").size(withAttributes: attributes)
            return CGSize(width: estimatedSize.width+22, height: 44)
        }
        return CGSize(width: 100, height: 200)
    }
}


// 선택안될때

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
