//
//  RecommendCollectionViewCell.swift
//  With
//
//  Created by JUNE on 2019/12/24.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class RecommendCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var recommendImage: UIImageView!
    @IBOutlet weak var recommendLabel: UILabel!
    var viewModel: HomeRecommendTrip! {
        willSet {
            let htmlRegion = newValue.regionNameEng
            let region = htmlRegion.components(separatedBy: "<br>")
            let regionName = region.count > 1 ? region[0]+"\n"+region[1] : region[0]
            recommendLabel.text = regionName
            let regionImg = newValue.regionImgS
            let imgURL = URL(string: regionImg )
            self.recommendImage.kf.indicatorType = .activity
            self.recommendImage.kf.setImage(with: imgURL, options: [.transition(.fade(0.3)), .cacheOriginalImage])
            
        }
    }
}
