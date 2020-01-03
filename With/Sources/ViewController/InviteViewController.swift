//
//  InviteViewController.swift
//  With
//
//  Created by 남수김 on 2019/12/31.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import Firebase
class InviteViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var titleLabel: UILabel!
    var ref: DatabaseReference!
    var otherId = 0
    var roomId = ""
    var otherUnSeenCount = 0
    var boardIdx = 0
    var otherName = ""
    let dateFommatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter
    }()
    let fullDateFommatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 MM월 dd일 HH:mm"
        return formatter
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleLabel(name: otherName)
        let today = dateFommatter.string(from: Date())
        self.datePicker.minimumDate = dateFommatter.date(from: today)
        setFirebase()
    }

    func setTitleLabel(name: String) {
        let count = name.count
        let attributedString = NSMutableAttributedString(string: "\(name)님과\nW!TH할래요?", attributes: [
          .font: UIFont(name: "AppleSDGothicNeo-Bold", size: 20.0)!,
          .foregroundColor: UIColor(white: 0.0, alpha: 1.0),
          .kern: -0.01
            ])
        attributedString.addAttribute(.font, value: UIFont(name: "AppleSDGothicNeo-Regular", size: 20.0)!, range: NSRange(location: count+1, length: 2))
        attributedString.addAttribute(.foregroundColor, value: UIColor.mainPurple, range: NSRange(location: count+3, length: 4))
        attributedString.addAttribute(.font, value: UIFont(name: "AppleSDGothicNeo-Regular", size: 20.0)!, range: NSRange(location: count+7, length: 4))
        
        self.titleLabel.attributedText = attributedString
    }
    @IBAction func inviteButtonClick(_ sender: Any) {
        let date = dateFommatter.string(from: self.datePicker.date)
        self.sendInvite(date: date) { bool in
            if bool {
                self.dismiss(animated: true)
            } else {
                self.simpleAlert(title: "전송 실패", msg: "전송에 실패하였습니다.")
            }
        }
    }
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
