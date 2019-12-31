//
//  RegionCollectionViewCell.swift
//  With
//
//  Created by JUNE on 2019/12/26.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class RegionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var regionLine: UIView!
    var regionCode = ""
    var isClick = false {
        willSet {
            if newValue {
                self.regionLabel.textColor = UIColor.black
                self.regionLine.isHidden = false
            } else {
                self.regionLabel.textColor = UIColor.lightGray
                self.regionLine.isHidden = true
            }
        }
    }
//    var isClick: Bool = true {
//        willSet {
//            print(newValue)
//            if newValue {
//                self.regionLine.isHidden = false
//                self.regionLabel.textColor = UIColor.black
//                self.regionLine.frame.size.height = 1
//                self.regionLine.backgroundColor = UIColor(red: 49/255, green: 26/255, blue: 128/255, alpha: 1)
//            } else {
//                self.regionLabel.textColor = UIColor.lightGray
//                self.regionLine.isHidden = true
//            }
//            self.layoutIfNeeded()
//        }
//    }
}
