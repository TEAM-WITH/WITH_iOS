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
    @IBOutlet weak var meetTimeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var view: UIView!
    
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
        nameLabel.textAlignment = .center
        self.view.layer.borderWidth = 1
        self.view.layer.borderColor = UIColor.acceptBtColor.cgColor
        self.view.layer.cornerRadius = 6
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
// 파베통신코드짜기
