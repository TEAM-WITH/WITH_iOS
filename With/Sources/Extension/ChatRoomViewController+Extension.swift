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
    }
    func firebaseEventObserver() {
        let roomid = "1_4"
        self.ref.child("conversations").child("1_4").observe(.value) { (snapshot) in
            print(snapshot)
            self.chatList.removeAll()
            for item in snapshot.children.allObjects as! [DataSnapshot] {
                if let object = item.value as? [String: AnyObject] {
                    print("***chatRoomic: \(object["msg"])")
                    guard let typeNum = object["type"] as? Int else { return }
                    guard let dateString = object["date"] as? String else { return }
                    guard let msg = object["msg"] as? String else { return }
                    guard let userIdx = object["userIdx"] as? Int else { return }
                   
                    var type = self.typeChange(useridx: userIdx, typeNum: typeNum)
                    
                    guard let tempDate = self.fullDateFommatter.date(from: dateString) else { return }
                    let date = self.dateFommatter.string(from: tempDate)
                    let chat = Chat(type: type, userIdx: userIdx, message: msg, date: date)
                    self.chatList.append(chat)
                }
            }
            self.dateAllCompare()
            self.chatTableView.reloadData()
        }
    }
    
    func sendChat(user1: String, user2: String, msg: String, completion: @escaping (Bool) -> Void) {
        let time = fullDateFommatter.string(from: Date())
        let createChatInfo: Dictionary<String, Any> = [
            "date": time,
            "msg": msg,
            "type": 0,
            "userIdx": 4
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
    func typeChange(useridx: Int, typeNum: Int) -> ChatType {
        if useridx == self.user {
            switch typeNum {
            case 0:
                return .mine
            case 1:
                return .other
            case 2:
                return .myInvite
            case 3:
                return .otherInvite
            case 4:
                return .complete
            default:
                return .date
                
            }
        } else {
            switch typeNum {
            case 0:
                return .other
            case 1:
                return .mine
            case 2:
                return .otherInvite
            case 3:
                return .myInvite
            case 4:
                return .complete
            default:
                return .date
            }
        }
    }
}
