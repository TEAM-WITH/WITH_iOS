//
//  RecentCollectionViewCell.swift
//  With
//
//  Created by JUNE on 2019/12/25.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class RecentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var recentWriteLabel: UILabel!
    @IBOutlet weak var recentProImage: UIImageView!
    @IBOutlet weak var recentNameLabel: UILabel!
    @IBOutlet weak var recentCountryboxColor: UIView!
    @IBOutlet weak var recentCountryLabel: UILabel!
    
 
    @IBOutlet weak var recentContentView: UIView!
    override func awakeFromNib() {
        self.recentProImage.layer.cornerRadius = self.recentProImage.frame.width/2
    
          self.recentContentView.layer.cornerRadius = 5
         self.recentContentView.layer.borderWidth = 1
        self.recentContentView.layer.borderColor = UIColor.lightGray.cgColor
  
    
        
    }
    
    
    
}
