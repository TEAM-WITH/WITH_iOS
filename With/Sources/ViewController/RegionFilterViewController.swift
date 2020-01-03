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
    
    var regionSet: [Region] = []
    var defaultValue = 0
    var beforeValue = 0
    var semiBeforeValue = 0
    var semiCurValue = 0
    var countryDataset: [CountryModel] = []
    var delegate: BoardPickDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setRegionName()
        
        //        setCountryData()
        //        countryTableView.reloadData()
        
        self.countryTableView.dataSource = self
        self.countryTableView.delegate = self
        self.regionCollectionView.dataSource = self
        self.regionCollectionView.delegate = self
        self.semiRegionCollectionView.dataSource = self
        self.semiRegionCollectionView.delegate = self
        self.regionCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
        self.semiRegionCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
        
        setDefaultCountry(regionCode: regionSet[0].region.code)
    }
    @IBAction func pressXButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func setDefaultCountry(regionCode: String) {
        CountryService.shared.getCountryRequest(regionCode: regionCode) { data in
            if let countrySet = data {
                self.countryDataset = countrySet
                self.countryTableView.reloadData()
            }
        }
    }
}

extension RegionFilterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.regionCollectionView {
            return regionSet.count
        } else if collectionView == semiRegionCollectionView {
            return regionSet[defaultValue].data.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.regionCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegionCell", for: indexPath) as! RegionCollectionViewCell
            cell.isClick = self.regionSet[indexPath.item].region.isClick
            cell.regionLabel.text = self.regionSet[indexPath.item].region.name
            cell.regionCode = self.regionSet[indexPath.item].region.code
            return cell
        } else if collectionView == self.semiRegionCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SemiRegionCell", for: indexPath) as! SemiRegionCollectionViewCell
            cell.isClick = self.regionSet[self.defaultValue].data[indexPath.item].isClick
            cell.regionCode = self.regionSet[self.defaultValue].data[indexPath.item].code
            cell.semiRegionLabel.text = self.regionSet[self.defaultValue].data[indexPath.item].name
            return cell
        }
        return UICollectionViewCell()
    }
}
extension RegionFilterViewController: UICollectionViewDelegate {
    // 선택될때
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if collectionView == self.regionCollectionView {
            
            semiBeforeValue = 0
            self.regionSet[indexPath.item].region.isClick = true
            self.regionSet[self.beforeValue].region.isClick = false
            
            defaultValue = indexPath.item
            for index in 1..<self.regionSet[self.defaultValue].data.count {
                self.regionSet[self.defaultValue].data[index].isClick = false
            }
            self.regionSet[self.defaultValue].data[0].isClick = true
            
            let regionCode = self.regionSet[self.defaultValue].region.code
                  CountryService.shared.getCountryRequest(regionCode: regionCode) { data in
                      if let countrySet = data {
                          self.countryDataset = countrySet
                          self.countryTableView.reloadData()
                      }
                  }
            
            self.semiRegionCollectionView.reloadData()
            self.semiRegionCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
            
        } else if collectionView == self.semiRegionCollectionView {
          
            semiCurValue = indexPath.item
            self.regionSet[self.defaultValue].data[semiCurValue].isClick = true
            self.regionSet[self.defaultValue].data[semiBeforeValue].isClick = false
            //            self.countryTableView.reloadData()
            
            
            let regionCode = self.regionSet[self.defaultValue].data[semiCurValue].code
            CountryService.shared.getCountryRequest(regionCode: regionCode) { data in
                if let countrySet = data {
                    self.countryDataset = countrySet
                    self.countryTableView.reloadData()
                }
            }
        }

    }
    // 선택안될때
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == regionCollectionView {
            beforeValue = defaultValue
            self.regionCollectionView.reloadData()
        } else if collectionView == semiRegionCollectionView {
            semiBeforeValue = indexPath.item
            self.semiRegionCollectionView.reloadData()
        }
    }

}


extension RegionFilterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == regionCollectionView {
            let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
            let estimatedSize = NSString(string: regionSet[indexPath.item].region.name).size(withAttributes: attributes)
            return CGSize(width: estimatedSize.width+2, height: 44)
        } else if collectionView == semiRegionCollectionView {
            let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
            let estimatedSize = NSString(string: regionSet[self.defaultValue].data[indexPath.item].name).size(withAttributes: attributes)
            return CGSize(width: estimatedSize.width+22, height: 44)
        }
        return CGSize(width: 100, height: 200)
    }
}


extension RegionFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == countryTableView {
            return countryDataset.count
        }
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countryTableView.dequeueReusableCell(withIdentifier: "CountryCell") as! CountryCellTableViewCell
        
        let country = self.countryDataset[indexPath.row]
        cell.viewModel = country
             
             return cell
    }
}

extension RegionFilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let regionCode = self.countryDataset[indexPath.row].regionCode
        let regionName = self.countryDataset[indexPath.row].regionName
        self.delegate?.getRegion?(regionCode: regionCode, regionName: regionName)
        self.dismiss(animated: true)
    }
}

extension RegionFilterViewController {
    func setRegionName() {
        let wholeEu = Country(code: "010000", name: "전체", isClick: true)
        let westernEu = Country(code: "010100", name: "서유럽")
        let easternEu = Country(code: "010200", name: "동유럽")
        let northernEu = Country(code: "010300", name: "북유럽")
        let europe = Region(region: Country(code: "010000", name: "유럽", isClick: true),data: [wholeEu, westernEu, easternEu, northernEu])
        
        let wholeAsia = Country(code: "020000", name: "전체")
        let eastNorthAsia = Country(code: "020100", name: "동북아시아")
        let eastSouthAsia = Country(code: "020200", name: "동남아시아")
        let southAsia = Country(code: "020300", name: "남부아시아")
        let westSouthAsia = Country(code: "020400", name: "서남아시아")
        let asia = Region(region: Country(code: "020000", name: "아시아"),data: [wholeAsia, eastNorthAsia, eastSouthAsia, southAsia, westSouthAsia])
        
        let wholeNA = Country(code: "030000", name: "전체")
        let northAmerica = Region(region: Country(code: "030000", name: "북아메리카"),data: [wholeNA])
        
        let wholeSA = Country(code: "040000", name: "전체")
        let southAmerica = Region(region: Country(code: "040000", name: "남아메리카"),data: [wholeSA])
        
        let wholeOC = Country(code: "050000", name: "전체")
        let oceania = Region(region: Country(code: "050000", name: "오세아니아"),data: [wholeOC])
        
        let wholeAF = Country(code: "060000", name: "전체")
        let northAF = Country(code: "060100", name: "북아프리카")
        let southAF = Country(code: "060200", name: "남아프리카")
        let eastAF = Country(code: "060300", name: "동아프리카")
        let africa = Region(region: Country(code: "060000", name: "아프리카"),data: [wholeAF, northAF, southAF, eastAF])
        
        let wholeKorea = Country(code: "070000", name: "전체")
        let korea = Region(region: Country(code:"070000",name: "  국내  "),data: [wholeKorea])
        
        let blank = Country(code: "", name: "blank")
        let bbblank = Region(region: Country(code: "", name: "    "),data: [blank])
        regionSet = [europe,asia,northAmerica,southAmerica,africa,oceania,korea,bbblank]
    }
}
