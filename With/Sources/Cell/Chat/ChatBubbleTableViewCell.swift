//
//  ChatBubbleTableViewCell.swift
//  With
//
//  Created by 남수김 on 2019/12/24.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class ChatBubbleTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var chatTextLabel: UILabel!
    var hide = false {
        willSet {
            self.hide = newValue
            self.timeLabel.isHidden = newValue
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.chatTextLabel.labelKern(kerningValue: -0.78)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
