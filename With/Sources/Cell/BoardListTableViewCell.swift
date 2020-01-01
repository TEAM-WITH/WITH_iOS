//
//  BoardListTableViewCell.swift
//  With
//
//  Created by 남수김 on 2020/01/02.
//  Copyright © 2020 ns. All rights reserved.
//

import UIKit
import Kingfisher
class BoardListTableViewCell: UITableViewCell {

    @IBOutlet weak var withCountLabel: UILabel!
    @IBOutlet weak var recentTimeLabel: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    var boardIdx: Int!
    var regionCode: String!
    var filter: Int!
    var viewModel: BoardResult! {
        willSet {
            boardIdx = newValue.boardIdx
            regionCode = newValue.regionCode
            filter = newValue.filter
            withCountLabel.text = "\(newValue.withNum)"
            recentTimeLabel.text = newValue.uploadTime
            recentTimeLabel.sizeToFit()
            titleLabel.text = newValue.title
            dateLabel.text = "\(newValue.startDate) ~ \(newValue.endDate)"
            regionLabel.text = newValue.regionName
            do {
                guard let imgURL = URL(string: newValue.userImg) else { return }
                profileImg.kf.setImage(with: imgURL, options: [.transition(.fade(0.5)), .cacheOriginalImage])
            } catch (let err) {
                print(err.localizedDescription)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
