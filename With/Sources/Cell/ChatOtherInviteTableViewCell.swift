//
//  ChatOtherInviteTableViewCell.swift
//  With
//
//  Created by 남수김 on 2019/12/27.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class ChatOtherInviteTableViewCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var msgImage: UIImageView!
    @IBOutlet weak var msgLabel: UILabel!
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
    @IBAction func acceptButtonClick(_ sender: UIButton) {
        sender.backgroundColor = UIColor.acceptBtColor
        sender.isEnabled = false
    }
}
