//
//  ChatDateTableViewCell.swift
//  With
//
//  Created by 남수김 on 2019/12/26.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class ChatDateTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.dateLabel.labelKern(kerningValue: -0.06)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
