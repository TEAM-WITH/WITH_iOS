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
    var serverModel: ChatListResult! {
        willSet {
            
            self.userIdLabel.text = newValue.name
            let imgURL = URL(string: newValue.writerImg)
            self.profileImage.kf.setImage(with: imgURL)
            self.roomId = newValue.roomId
            self.chatTitleLabel.text = newValue.title
        }
    }
    var firebaseMdoel: ChatList! {
        willSet {
            if newValue.unSeenCount == 0 {
                self.badgeView.isHidden = true
            } else {
                self.badgeLabel.text = "\(newValue.unSeenCount)"
                self.badgeView.isHidden = false
            }
//            self.badgeLabel.text = "\(newValue.unSeenCount)"
            self.timeLabel.text = newValue.time
            self.chatContentLabel.text = newValue.lastMsg
            
        }
    }
    var roomId = ""
    var url = "" {
        willSet {
            let imgURL = URL(string: newValue)
            self.profileImage.kf.setImage(with: imgURL, options: [.transition(.fade(0.2)), .cacheOriginalImage])
        }
    }
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
   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.timeLabel.textColor = UIColor.acceptBtColor
        self.timeLabel.labelKern(kerningValue: -0.06)
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
