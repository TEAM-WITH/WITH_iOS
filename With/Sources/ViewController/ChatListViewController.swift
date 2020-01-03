//
//  ChatListViewController.swift
//  With
//
//  Created by 남수김 on 2019/12/25.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import Firebase
class ChatListViewController: UIViewController {
   let dateFommatter: DateFormatter = {
       let formatter = DateFormatter()
       formatter.locale = Locale(identifier: "ko_KR")
       formatter.dateFormat = "hh:mm"
       return formatter
   }()
   let fullDateFommatter: DateFormatter = {
       let formatter = DateFormatter()
       formatter.locale = Locale(identifier: "ko_KR")
       formatter.dateFormat = "yyyy년 MM월 dd일 HH:mm"
       return formatter
   }()
    var chatLists: [ChatList] = []
    var chatInfoList: [ChatListResult] = []
    var ref: DatabaseReference!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setFirebase()
        firebaseEventObserver(userIdx: "\(UserInfo.shared.getUserIdx())")
        chatListRequest()
    }
    override func viewWillDisappear(_ animated: Bool) {
        if let index = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: index, animated: true)
        }
        ref.removeAllObservers()
    }
    func distinguishGetOtherId(roomId: String) -> Int {
        let sub = roomId.split(separator: "_")
        
        let otherId = sub.filter{ return $0 != "\(UserInfo.shared.getUserIdx())" }
            .map{ Int($0) }
        return otherId[0] ?? -1
    }
    func chatListRequest() {
        ChatService.shared.getChatListRequest { data in
            if let infos = data {
                self.chatInfoList = infos
            }
        }
    }
}

extension ChatListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatList", for: indexPath) as! ChatListTableViewCell
        let data = chatLists[indexPath.row]
        cell.chatTitleLabel.text = "\(data.boardIdx)"
        cell.chatContentLabel.text = data.lastMsg
        cell.timeLabel.text = data.time
        cell.badgeCount = data.unSeenCount
        return cell
    }
}

extension ChatListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatRoom = chatLists[indexPath.row]
        let chatInfo = chatInfoList[indexPath.row]
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "Chat") as? ChatRoomViewController else { return }
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.roomId = chatInfo.roomId
        nextVC.otherUnSeenCount = chatRoom.unSeenCount
        nextVC.otherId = chatInfo.userIdx
        nextVC.roomInfo = chatInfo
        nextVC.inviteFlag = chatRoom.inviteFlag
        enterChatSetCount(roomId: chatRoom.roomId)
        self.present(nextVC, animated: true)
    }
}


