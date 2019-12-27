//
//  ChatProfileTableViewCell.swift
//  With
//
//  Created by 남수김 on 2019/12/26.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class ChatProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
