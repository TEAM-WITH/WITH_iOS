//
//  ChatListTableViewCell.swift
//  With
//
//  Created by 남수김 on 2019/12/28.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {

    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var badgeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var chatContentLabel: UILabel!
    @IBOutlet weak var chatTitleLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var acceptImage: UIImageView!
    var accept = false {
        willSet {
            if newValue {
                self.chatTitleLabel.textColor = UIColor.meetOtherColor
            } else {
                self.chatTitleLabel.textColor = UIColor.black
            }
            self.acceptImage.isHidden = newValue
        }
    }
    var badgeCount = 0 {
        willSet {
            if newValue == 0 {
                self.badgeView.isHidden = true
            } else {
                self.badgeLabel.text = "\(newValue)"
                self.badgeView.isHidden = false
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.timeLabel.textColor = UIColor.acceptBtColor
        self.timeLabel.labelKern(kerningValue: -0.06)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
