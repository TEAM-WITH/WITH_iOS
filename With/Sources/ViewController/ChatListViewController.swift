//
//  ChatListViewController.swift
//  With
//
//  Created by 남수김 on 2019/12/25.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import Firebase
import Lottie
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
    @IBOutlet weak var lottieLoading: AnimationView!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
//        setFirebase()
//        firebaseEventObserver()
//        chatListRequest()
    }
    override func viewWillAppear(_ animated: Bool) {

        setFirebase()
        firebaseEventObserver()
        chatListRequest()
    }

    override func viewWillDisappear(_ animated: Bool) {
        if let index = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: index, animated: true)
        }
    }
   
    func chatListRequest() {
        ChatService.shared.getChatListRequest { data in
            if let infos = data {
                self.chatInfoList = infos
                self.lottieLoading.stop()
                self.lottieLoading.isHidden = true
//                var tempList: [ChatList] = []
//                for list in self.chatLists {
//                    for info in infos {
//                        if list.boardIdx == info.boardIdx {
//                            tempList.append(list)
//                        }
//                    }
//                }
//                self.chatLists = tempList
//                self.tableView.reloadData()
            }
         
        }
    }
}
// 영현 115 하담 122
extension ChatListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatList", for: indexPath) as! ChatListTableViewCell
        cell.serverModel = chatInfoList[indexPath.row]
        cell.firebaseMdoel =  chatLists[indexPath.row]
//        cell.chatTitleLabel.text = self.chatInfoList[indexPath.row].title
//        cell.chatContentLabel.text = data.lastMsg
//        cell.timeLabel.text = data.time
//        cell.badgeCount = data.unSeenCount
        
//        cell.roomId = chatLists[indexPath.row].roomId
//        cell.url = self.chatInfoList[indexPath.row].userImg
        return cell
    }
}

extension ChatListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ChatListTableViewCell
        
        guard let fire = cell.firebaseMdoel else { return }
        guard let server = cell.serverModel else {return}
        
        let roomid = server.roomId
//        let chatRoom = roomid
        let chatInfo = chatInfoList[indexPath.row]
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "Chat") as? ChatRoomViewController else { return }
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.roomId = roomid
        print(roomid)
        nextVC.otherUnSeenCount = fire.unSeenCount
        nextVC.otherId = server.userIdx
        nextVC.roomInfo = chatInfo
        nextVC.regionName = server.regionName!
        nextVC.inviteFlag = fire.inviteFlag
        nextVC.noticeTitle = server.title
        nextVC.otherName = server.name
        nextVC.imgUrl = server.writerImg
        nextVC.boardIdx = server.boardIdx
        let date = "\(server.startDate) ~ \(server.endDate)"
        nextVC.date = date
        enterChatSetCount(roomId: "\(roomid)")
        
        self.present(nextVC, animated: true)
    }
}


