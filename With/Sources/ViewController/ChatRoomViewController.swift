//
//  ChatRoomViewController.swift
//  With
//
//  Created by 남수김 on 2019/12/24.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class ChatRoomViewController: UIViewController {

    let chat1 = Chat(type: .my, nickName: "my", message: "hihi")
    let chat2 = Chat(type: .my, nickName: "my", message: "hey~~~")
    let chat3 = Chat(type: .your, nickName: "your", message: "hihi")
    let chat4 = Chat(type: .your, nickName: "your", message: "merry")
    let chat5 = Chat(type: .your, nickName: "your", message: "...")
    let chat6 = Chat(type: .your, nickName: "your", message: "hoo... nononononononononononononononononononononononononononono")
    
    var testList: [Chat] = []
    var chatList: [Chat] = []
    @IBOutlet weak var chatTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chatTableView.dataSource = self
        self.chatTableView.delegate = self
        testList = [chat1,chat2,chat3,chat4,chat5,chat6]
    }
}

extension ChatRoomViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = testList[indexPath.row]
        let cellid = chat.type == .my ? "MyChatCell" : "YourChatCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! ChatBubbleTableViewCell
        cell.chatTextLabel.text = chat.message
        return cell
    }
}

extension ChatRoomViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         let chat = testList[indexPath.row]
        let approximateWidthOfText = view.frame.width - 19 - 103
        let size = CGSize(width: approximateWidthOfText, height: 1000)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        let estimatedFrame = NSString(string: chat.message).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return estimatedFrame.height + 7 + 7 + 4
    }
}

struct Chat {
    var type: ChatType
    var nickName: String
    var message: String
}

enum ChatType {
    case my
    case your
}
