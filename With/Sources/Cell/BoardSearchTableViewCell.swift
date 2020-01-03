//
//  BoardSearchTableViewCell.swift
//  With
//
//  Created by 남수김 on 2020/01/02.
//  Copyright © 2020 ns. All rights reserved.
//

import UIKit

class BoardSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var historyLabel: UILabel!
    var id: String!
    var data: SearchData! {
        willSet {
            self.id = newValue.id
            self.historyLabel.text = newValue.item
            self.deleteButton.tag = Int(newValue.id) ?? -1
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}

class BoardDeleteTableCell: UITableViewCell {
    @IBOutlet weak var allDeleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
