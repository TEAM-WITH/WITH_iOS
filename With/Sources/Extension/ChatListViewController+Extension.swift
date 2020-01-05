//
//  ChatListViewController+Extension.swift
//  With
//
//  Created by 남수김 on 2019/12/31.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import Firebase

struct ChatTotalModel {
    var boardIdx: Int
    var inviteFlag: Int
    var lastMessage: String
    var lastTime: String
    var unSeenCount: Int
    var otherName: String
    var userIdx: Int
    var roomId: String
    var regionName: String?
    var title: String
    var withDate: String?
    var startDate: String
    var endDate: String
    var withFlag: Int?
    var evalFlag: Int?
    var writerImg: String
    var regionImgE: String?
    
}
extension ChatListViewController {
    func setFirebase() {
        self.ref = Database.database().reference()
    }
    
    func firebaseEventObserver() {
        let userId = UserInfo.shared.getUserIdx()
        self.chatLists.removeAll()
        self.ref.child("users").child("\(userId)").observe(.childAdded) { snapshot in
            
            if let object = snapshot.value as? [String: AnyObject] {
                guard let boardIdx = object["boardIdx"] as? Int else { return }
                guard let inviteFlag = object["inviteFlag"] as? Int else { return }
                guard let lastMessage = object["lastMessage"] as? String else { return }
                guard let lastTime = object["lastTime"] as? String else { return }
                guard let unSeenCount = object["unSeenCount"] as? Int else { return }
                
                guard let fullDate = self.fullDateFommatter.date(from: lastTime) else { return }
                
                let time = self.dateFommatter.string(from: fullDate)
                let temp = ChatList(boardIdx: boardIdx, lastMsg: lastMessage, unSeenCount: unSeenCount, time: time, inviteFlag: inviteFlag)
                
                self.chatLists.append(temp)
                
                self.tableView.reloadData()
            }
            
            
        }
    }


//    func firebaseEventObserver(userIdx: String) {
//        var tempList = [ChatList]()
//        let userIdx = UserInfo.shared.getUserIdx()
//            self.ref.child("users").child("\(userIdx)").observe(.value) { (snapshot) in
//
////                print(snapshot)
//
//                for item in snapshot.children.allObjects as! [DataSnapshot] {
//                    if let object = item.value as? [String: AnyObject] {
//
//                        guard let boardIdx = object["boardIdx"] as? Int else { return }
//                        guard let lastMsg = object["lastMessage"] as? String else { return }
//                        guard let lastTime = object["lastTime"] as? String else { return }
//                        guard let unSeenCount = object["unSeenCount"] as? Int else { return }
//                        guard let inviteFlag = object["inviteFlag"] as? Int else { return }
//                        guard let fullDate = self.fullDateFommatter.date(from: lastTime) else { return }
//                        let time = self.dateFommatter.string(from: fullDate)
//                        let roomId = item.key
//                        let chatRoom = ChatList(boardIdx: boardIdx, lastMsg: lastMsg, unSeenCount: unSeenCount, time: time, roomId: roomId, inviteFlag: inviteFlag)
//
//                        tempList.append(chatRoom)
//                    }
//                }
//                print("**fire**")
//                print(tempList)
//                print("****")
//                self.chatLists.removeAll()
//
//
//                ChatService.shared.getChatListRequest { data in
//                    if let infos = data {
//                        self.chatInfoList = infos
//                        self.lottieLoading.stop()
//                        self.lottieLoading.isHidden = true
//
//                    }
//                    var tempInfo: [ChatListResult]!
//                    for info in self.chatInfoList {
//                        for room in tempList {//fire
//                            if room.roomId == info.roomId && room.boardIdx != 0{
//                                self.chatLists.append(room)
//                                tempInfo.append(info)
//                                break
//                            }
//                        }
//                    }
//                    self.chatInfoList.removeAll()
//                    self.chatInfoList = tempInfo
//
//                    self.tableView.reloadData()
//                }
//
//        }
//    }
    
    func enterChatSetCount(roomId: String) {
        // 들어갈때 카운트 0초기화
        let user = UserInfo.shared.getUserIdx()
        let resetCount: [String: Any] = ["unSeenCount": 0]
        ref.child("users").child("\(user)").child(roomId).updateChildValues(resetCount)
    }
    
}
