//
//  ChatListViewController+Extension.swift
//  With
//
//  Created by 남수김 on 2019/12/31.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import Firebase
extension ChatListViewController {
    func setFirebase() {
        self.ref = Database.database().reference()
    }
    func firebaseEventObserver(userIdx: String) {
            self.ref.child("users").child(userIdx).observe(.value) { (snapshot) in
                self.chatLists.removeAll()
                for item in snapshot.children.allObjects as! [DataSnapshot] {
                    if let object = item.value as? [String: AnyObject] {
//                        print(object)
                        guard let boardIdx = object["boardIdx"] as? Int else { return }
                        guard let lastMsg = object["lastMessage"] as? String else { return }
                        guard let lastTime = object["lastTime"] as? String else { return }
                        guard let unSeenCount = object["unSeenCount"] as? Int else { return }
                        guard let fullDate = self.fullDateFommatter.date(from: lastTime) else { return }
                        let time = self.dateFommatter.string(from: fullDate)
                        let roomId = item.key
                        let chatRoom = ChatList(boardIdx: boardIdx, lastMsg: lastMsg, unSeenCount: unSeenCount, time: time, roomId: roomId)
                        self.chatLists.append(chatRoom)
                       
                        
                    }
                }
                self.tableView.reloadData()
            }
        }
    
    func enterChatSetCount(roomId: String) {
        // 들어갈때 카운트 0초기화
        let user = UserInfo.shared.getUserIdx()
        let resetCount: [String: Any] = ["unSeenCount": 0]
        ref.child("users").child("\(user)").child(roomId).updateChildValues(resetCount)
    }
    
}
