//
//  ChatRoomViewController.swift
//  With
//
//  Created by 남수김 on 2019/12/24.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import Alamofire
class ChatRoomViewController: UIViewController {

    let chat1 = Chat(type: .mine, nickName: "my", message: "hihi")
    let chat2 = Chat(type: .mine, nickName: "my", message: "hey~~~")
    let chat3 = Chat(type: .your, nickName: "your", message: "hihi")
    let chat4 = Chat(type: .your, nickName: "your", message: "merry")
    let chat5 = Chat(type: .your, nickName: "your", message: "...")
    let chat6 = Chat(type: .your, nickName: "your", message: "hoo... nononononononononononononononononononononononononononono")
    let chat7 = Chat(type: .date, message: "2020.02.10")
    let chat8 = Chat(type: .profile, nickName: "you")
    
    var testList: [Chat] = []
    var chatList: [Chat] = []
    @IBOutlet weak var chatTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chatTableView.dataSource = self
        self.chatTableView.delegate = self
        testList = [chat1,chat2,chat3,chat4,chat5,chat6,chat7,chat8]
        
    }
    
}

extension ChatRoomViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let chat = testList[indexPath.row]
        if chat.type == .date {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! ChatDateTableViewCell
            cell.dateLabel.text = chat.message
            return cell
        }else if chat.type == .profile {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ChatProfileTableViewCell
            cell.userIdLabel.text = chat.message
            return cell
        }
        let cellid = chat.type == .mine ? "MyChatCell" : "YourChatCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! ChatBubbleTableViewCell
        cell.chatTextLabel.text = chat.message
        return cell
    }
}

extension ChatRoomViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let chat = testList[indexPath.row]
        if chat.type == .profile {
            return 42
        } else if chat.type == .date {
            return 55
        } else {
            let approximateWidthOfText = view.frame.width - 16 - 103
            let size = CGSize(width: approximateWidthOfText, height: 1200)
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]
            let estimatedFrame = NSString(string: chat.message ?? "").boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            return estimatedFrame.height + 13 + 13
        }
    }
}

struct Chat {
    var type: ChatType
    var nickName: String?
    var message: String?
    var date: Date?
}

enum ChatType {
    case mine
    case your
    case date
    case profile
    case accept
    case agree
}
