//
//  ChatCompleteTableViewCell.swift
//  With
//
//  Created by 남수김 on 2019/12/27.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class ChatCompleteTableViewCell: UITableViewCell {

    @IBOutlet weak var msgImage: UIImageView!
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var hide = false {
        willSet {
            self.hide = newValue
            self.timeLabel.isHidden = newValue
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        msgLabel.labelKern(kerningValue: -0.84)
        msgLabel.labelParagraphStyle(paragraphValue: 5.5)
        msgLabel.textAlignment = .center
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
