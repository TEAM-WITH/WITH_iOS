//
//  ChatMyInviteTableViewCell.swift
//  With
//
//  Created by 남수김 on 2019/12/27.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class ChatMyInviteTableViewCell: UITableViewCell {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var msgImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var meetTimeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var hide = false {
        willSet {
            self.hide = newValue
            self.timeLabel.isHidden = newValue
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        meetTimeLabel.labelKern(kerningValue: -0.84)
        meetTimeLabel.labelParagraphStyle(paragraphValue: 5.5)
        meetTimeLabel.textAlignment = .center
        nameLabel.labelKern(kerningValue: -0.84)
        nameLabel.labelParagraphStyle(paragraphValue: 5.5)
        nameLabel.textAlignment = .right
        self.view.layer.borderWidth = 1
        self.view.layer.borderColor = UIColor.acceptBtColor.cgColor
        self.view.layer.cornerRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
