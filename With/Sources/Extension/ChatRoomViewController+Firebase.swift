//
//  ChatRoomViewController+Firebase.swift
//  With
//
//  Created by 남수김 on 2019/12/30.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import UIKit
import Firebase
extension ChatRoomViewController {
    func setFirebase() {
        self.ref = Database.database().reference()
        self.ref.child("conversations")
    }
    func firebaseEventObserver() {
        let roomid = "a_b"
        self.ref.observe(.value) { (snapshot) in
            for item in snapshot.children.allObjects as! [DataSnapshot] {
                if let chatRoomic = item.value as? [String: AnyObject] {
//                    print("***chatRoomic: \(item.key)") //conversation, users
                    let list = chatRoomic.keys // 채팅목록 불러오기
//                    print("***list: \(list)")
//                    print(chatRoomic)
                    self.getChatList(chatData: chatRoomic[roomid])
                }
            }
        }
    }
    
    func getChatList(chatData: AnyObject?) {
        guard let data = chatData as? Data else { return }
        do {
        let object = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
        } catch {
            print("list err")
        }
        
    }
    
    func sendChat(user1: String, user2: String, msg: String, completion: @escaping (Bool) -> Void) {
        let time = fullDateFommatter.string(from: Date())
        let createChatInfo: Dictionary<String, Any> = [
            "date": time,
            "msg": msg,
            "type": 0,
            "userIdx": 1
            ]
        ref.child("conversations").child("\(user1)_\(user2)").childByAutoId().setValue(createChatInfo)
        let createRoomInfo: Dictionary<String, Any> = [
            "boardIdx": 0,
            "lastMessage": msg,
            "lastTime": time,
            "unSeenCount": 0
        ]
        ref.child("users").child("\(user1)").child("\(user1)_\(user2)").setValue(createRoomInfo)
        ref.child("users").child("\(user2)").child("\(user1)_\(user2)").setValue(createRoomInfo) { err, dref in
            if err == nil  {
                print("no err")
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
