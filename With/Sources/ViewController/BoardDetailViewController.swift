//
//  BoardDetailViewController.swift
//  With
//
//  Created by 남수김 on 2020/01/02.
//  Copyright © 2020 ns. All rights reserved.
//

import UIKit

class BoardDetailViewController: UIViewController {

    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userCommentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var badgeImg: UIImageView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userInfo: UILabel!
    var boardIdx: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        getSetBoardInfo()
        self.tabBarController?.tabBar.isHidden = true
        self.profileImg.layer.cornerRadius = self.profileImg.frame.width/2
    }
    func getSetBoardInfo() {
        BoardService.shared.getBoardDetailRequest(boardIdx: boardIdx) {  data in
            guard data != nil else { return }
            
            if let intro = data?.intro {
                self.userCommentLabel.text = intro
            }
            if let name = data?.name {
            self.nameLabel.text = name
            }
            if let age = data?.birth {
                let gender = data?.gender == 1 ? "남자" : "여자"
                self.userInfo.text = "\(age)살 " + gender
            }
            if let title = data?.title {
                self.titleLabel.text = title
            }
            if let region = data?.regionName {
                self.regionLabel.text = region
            }
            if let sDate = data?.startDate, let eDate = data?.endDate {
                let date = "\(sDate) ~ \(eDate)"
                self.dateLabel.text = date
            }
            let isfilter = data?.filter == 1 ? "적용" : "미적용"
            self.filterLabel.text = isfilter
            self.contentTextView.text = data?.content
            self.backgroundImg.image = UIImage(named: "img")
            
            if let badge = data?.badge {
                var imgName = ""
                if badge < 70 {
                    imgName = "Boardlikelevel0"
                } else if badge < 80 {
                    imgName = "Boardlikelevel1"
                } else if badge < 90 {
                    imgName = "Boardlikelevel2"
                } else {
                    imgName = "Boardlikelevel3"
                }
                self.badgeImg.image = UIImage(named: imgName)
            }
                
            do {
                guard let imgURL = URL(string: data?.userImg ?? "") else { return }
                self.profileImg.kf.indicatorType = .activity
                self.profileImg.kf.setImage(with: imgURL, placeholder: UIImage(named: "defaultUserImg"), options: [ .transition(.fade(0.3)), .cacheOriginalImage])
            } catch {
                print(error.localizedDescription)
            }
            
            
        }
    }

    @IBAction func backButton(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
}
