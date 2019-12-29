//
//  ChatListViewController.swift
//  With
//
//  Created by 남수김 on 2019/12/25.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class ChatListViewController: UIViewController {
    let dum1 = ChatList(title: "프랑스:맥주좋아하세여?", content: "맥주먹을사람~", userId: "남수", accept: true, badgeNum: 23, time: "13:03")
    let dum2 = ChatList(title: "독일:맥주좋아하세여?", content: "세잔해~~~", userId: "남수", accept: false, badgeNum: 5, time: "13:04")
    let dum3 = ChatList(title: "한국:치킨좋아하세여?", content: "두잔해~~", userId: "남수", accept: true, badgeNum: 11, time: "13:06")
    let dum4 = ChatList(title: "위드:위드하세여?", content: "한잔해~", userId: "남수", accept: true, badgeNum: 27, time: "13:03")
    let dum5 = ChatList(title: "프랑스:맥주좋아하세여?", content: "맥주먹을사람~", userId: "남수", accept: false, badgeNum: 100, time: "13:03")
    var test: [ChatList] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
         test = [dum1, dum2, dum3, dum4, dum5]
    }
    override func viewWillDisappear(_ animated: Bool) {
        if let index = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: index, animated: true)
        }
    }
}

extension ChatListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return test.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatList", for: indexPath) as! ChatListTableViewCell
        let data = test[indexPath.row]
        cell.chatTitleLabel.text = data.title
        cell.chatContentLabel.text = data.content
        cell.timeLabel.text = data.time
        cell.badgeLabel.text = "\(data.badgeNum)"
        cell.userIdLabel.text = data.userId
        cell.accept = data.accept
        
        return cell
    }
}

extension ChatListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "Chat") as? ChatRoomViewController else { return }
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
    }
}

struct ChatList {
    var title: String
    var content: String
    var userId: String
    var accept: Bool
    var badgeNum: Int
    var time: String
}
