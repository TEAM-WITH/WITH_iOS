//
//  SemiRegionCollectionViewCell.swift
//  With
//
//  Created by JUNE on 2019/12/27.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class SemiRegionCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var semiRegionView: UIView!
    @IBOutlet weak var semiRegionLabel: UILabel!
    var regionCode = ""
    var isClick = false {
        willSet {
            if newValue {
                self.semiRegionLabel.textColor = UIColor.white
                self.semiRegionView.backgroundColor = UIColor(red: 49/255, green: 26/255, blue: 128/255, alpha: 1)
               
            } else {
                self.semiRegionLabel.textColor = UIColor(red: 49/255, green: 26/255, blue: 128/255, alpha: 1)
                self.semiRegionView.backgroundColor = UIColor.white
                
            }
        }
    }
    override func awakeFromNib() {
        self.semiRegionView.layer.borderWidth = 1
        self.semiRegionView.layer.borderColor = UIColor(red: 49/255, green: 26/255, blue: 128/255, alpha: 1).cgColor
    }
}
