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
    func firebaseEventObserver(roomId: String) {
        self.ref.child("conversations").child(roomId).observe(.value) { (snapshot) in
            self.chatList.removeAll()
            
            for item in snapshot.children.allObjects as! [DataSnapshot] {
                if let object = item.value as? [String: AnyObject] {
                    guard let typeNum = object["type"] as? Int else { return }
                    guard let dateString = object["date"] as? String else { return }
                    guard let msg = object["msg"] as? String else { return }
                    guard let userIdx = object["userIdx"] as? Int else { return }
                   
                    let type = self.typeChange(useridx: userIdx, typeNum: typeNum)
                    
                    guard let tempDate = self.fullDateFommatter.date(from: dateString) else { return }
                    
                    let date = self.dateFommatter.string(from: tempDate)
                    let chat = Chat(type: type, userIdx: userIdx, message: msg, date: date)
                    self.chatList.append(chat)
                }
            }
            self.dateAllCompare()
            self.chatTableView.reloadData()
            self.updateChat() {
                print("read msg")
            }
        }
    }
    
    func sendChat(other: String, msg: String, completion: @escaping (Bool) -> Void) {
        let user = UserInfo.shared.getUserIdx()
        let time = fullDateFommatter.string(from: Date())
        let createChatInfo: Dictionary<String, Any> = [
            "date": time,
            "msg": msg,
            "type": 0,
            "userIdx": user
            ]
        ref.child("conversations").child("\(user)_\(other)").childByAutoId().setValue(createChatInfo)
        let createRoomInfo: Dictionary<String, Any> = [
            "boardIdx": 0,
            "lastMessage": msg,
            "lastTime": time,
            "unSeenCount": 0
        ]
        ref.child("users").child("\(user)").child("\(user)_\(other)").setValue(createRoomInfo)
        ref.child("users").child("\(other)").child("\(user)_\(other)").setValue(createRoomInfo) { err, dref in
            if err == nil  {
                print("no err")
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    func typeChange(useridx: Int, typeNum: Int) -> ChatType {
        if useridx == UserInfo.shared.getUserIdx() {
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
                return .otherComplete
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
                return .otherComplete
            default:
                return .date
            }
        }
    }
}
