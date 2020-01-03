//
//  MateCollectionViewCell.swift
//  With
//
//  Created by JUNE on 2019/12/24.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class MateCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mateImage: UIImageView!
    @IBOutlet weak var mateLabel: UILabel!
    
    override func awakeFromNib() {
          self.mateImage.layer.cornerRadius = self.mateImage.frame.width/2
      }
      

    var viewModel: ChatListResult! {
        willSet {
            self.mateLabel.text = newValue.name
            
            let imgURL = URL(string: newValue.userImg)
            self.mateImage.kf.indicatorType = .activity
            self.mateImage.kf.setImage(with: imgURL, options: [.transition(.fade(0.3)), .cacheOriginalImage])
        }
    }
}
