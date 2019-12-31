//
//  InviteViewController+Extension.swift
//  With
//
//  Created by 남수김 on 2019/12/31.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension InviteViewController {
    func setFirebase() {
        self.ref = Database.database().reference()
    }
    
    func sendInvite(date: String, completion: @escaping (Bool) -> Void) {
        let curTime = fullDateFommatter.string(from: Date())
        let user = UserInfo.shared.getUserIdx()
        let msg = "동행 신청 메시지입니다."
        let createChatInfo: Dictionary<String, Any> = [
            "date": curTime,
            "msg": "\(msg)-\(date)",
            "type": 2,
            "userIdx": user
            ]
        ref.child("conversations").child(roomId).childByAutoId().setValue(createChatInfo)
        self.unSeenCount += 1
        let createRoomInfo: Dictionary<String, Any> = [
            "boardIdx": 0,
            "lastMessage": msg,
            "lastTime": curTime,
            "unSeenCount": self.unSeenCount
        ]
        ref.child("users").child("\(user)").child(roomId).setValue(createRoomInfo)
        ref.child("users").child("\(otherId)").child(roomId).setValue(createRoomInfo) { err, dref in
            if err == nil  {
                print("no err")
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
