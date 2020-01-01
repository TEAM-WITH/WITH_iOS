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
        self.ref.child("conversations").child(roomId).observe(.childAdded) { snapshot in
            if let object = snapshot.value as? [String: AnyObject] {
                guard let typeNum = object["type"] as? Int else { return }
                guard let dateString = object["date"] as? String else { return }
                guard let msg = object["msg"] as? String else { return }
                guard let userIdx = object["userIdx"] as? Int else { return }
                
                let type = self.typeChange(useridx: userIdx, typeNum: typeNum, msg: msg)
                guard let tempDate = self.fullDateFommatter.date(from: dateString) else { return }
                let date = self.dateFommatter.string(from: tempDate)
                var chat: Chat!
                if type == .myInvite || type == .otherInvite || type == .otherComplete {
                    let meetDate = self.splitMsgString(msg: msg)
                    print(meetDate)
                    chat = Chat(type: type, userIdx: userIdx, message: msg, date: date, meetDate: meetDate)
                } else {
                    chat = Chat(type: type, userIdx: userIdx, message: msg, date: date)
                }
                self.chatList.append(chat)
                var indexPath = IndexPath(row: self.chatList.count-1, section: 0)
                self.chatTableView.insertRows(at: [indexPath], with: .none)
                self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
                
                if type != .mine || type != .myInvite || type != .date {
                    self.dateCompare()
                }
                
                
            
                if self.userCompare() {
                    let otherProfile = Chat(type: .otherProfile, userIdx: self.otherId, nickName: self.otherName)
                    indexPath = IndexPath(row: self.chatList.count-1, section: 0)
                    self.chatList.insert(otherProfile, at: indexPath.row)
                    self.chatTableView.insertRows(at: [indexPath], with: .none)
                }
            }
            
        }
    }
    
    func splitMsgString(msg: String) -> String {
        let sub = msg.split(separator: "-")
        let date = String(sub[1])
        return date
    }
    
    // MARK: - 파베 메시지보내기
    func sendChat(msg: String, completion: @escaping (Bool) -> Void) {
        let user = UserInfo.shared.getUserIdx()
        let time = fullDateFommatter.string(from: Date())
        let createChatInfo: Dictionary<String, Any> = [
            "date": time,
            "msg": msg,
            "type": 0,
            "userIdx": user
        ]
        ref.child("conversations").child(roomId).childByAutoId().setValue(createChatInfo)
        self.otherUnSeenCount += 1
        let createRoomInfo: Dictionary<String, Any> = [
            "boardIdx": 0,
            "lastMessage": msg,
            "lastTime": time,
            "unSeenCount": 0
        ]
        let createOtherRoomInfo: Dictionary<String, Any> = [
            "boardIdx": 0,
            "lastMessage": msg,
            "lastTime": time,
            "unSeenCount": self.otherUnSeenCount
        ]
        ref.child("users").child("\(user)").child(roomId).setValue(createRoomInfo)
        ref.child("users").child("\(otherId)").child(roomId).setValue(createOtherRoomInfo) { err, dref in
            if err == nil  {
                print("no err")
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    func typeChange(useridx: Int, typeNum: Int, msg: String) -> ChatType {
        if useridx == UserInfo.shared.getUserIdx() {
            switch typeNum {
            case 0:
                return .mine
            case 2:
                //동행 성사 메시지
                //동행 신청 메시지
                if msg.contains("성사") {
                    return .otherComplete
                } else {
                    // if msg.contains("신청")
                    return .myInvite
                }
            default:
                return .date
                
            }
        } else {
            switch typeNum {
            case 0:
                return .other
            case 2:
                if msg.contains("성사") {
                    return .otherComplete
                }else {
                    //if msg.contains("신청")
                    return .otherInvite
                }
            default:
                return .date
            }
        }
    }
    // MARK: - 동행 수락메시지보내기
    @objc func acceptRequest() {
        let user = UserInfo.shared.getUserIdx()
        let date = Date()
        let time = fullDateFommatter.string(from: date)
//        let msgTime = monthFommatter.string(from: date)
        let createChatInfo: Dictionary<String, Any> = [
            "date": time,
            "msg": "동행 성사 메시지입니다.-\(self.meetDateString)",
            "type": 2,
            "userIdx": user
        ]
        // 날짜 받아서 수락완료누르기
        // 날짜 찍히는거 확인
        ref.child("conversations").child(roomId).childByAutoId().setValue(createChatInfo)
        self.otherUnSeenCount += 1
        let createRoomInfo: Dictionary<String, Any> = [
            "boardIdx": 0,
            "lastMessage": "동행 성사 메시지입니다.",
            "lastTime": time,
            "unSeenCount": 0
        ]
        let createOtherRoomInfo: Dictionary<String, Any> = [
            "boardIdx": 0,
            "lastMessage": "동행 성사 메시지입니다.",
            "lastTime": time,
            "unSeenCount": otherUnSeenCount
        ]
        ref.child("users").child("\(user)").child(roomId).setValue(createRoomInfo)
        ref.child("users").child("\(otherId)").child(roomId).setValue(createOtherRoomInfo) { err, dref in
            if err == nil  {
                print("no err")
            }else {
                print("err")
            }
        }
    }
    // MARK: - 뱃지 지우기
    func removeUnSeenCount() {
        let user = UserInfo.shared.getUserIdx()
        let resetCount: [String: Any] = ["unSeenCount": 0]
        
        ref.child("users").child("\(user)").child(roomId).updateChildValues(resetCount)
        
    }
    // MARK: - 상대방 뱃지수 가져오기
    func setOtherUnSeenCount() {
        ref.child("users").child("\(otherId)").child(roomId).observe(.childChanged) { snapshot in
            if let object = snapshot.value as? [String: AnyObject] {
             guard let unSeenCount = object["unSeenCount"] as? Int else { return }
                self.otherUnSeenCount = unSeenCount
            }
        }
    }
}
