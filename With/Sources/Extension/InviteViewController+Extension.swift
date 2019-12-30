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
    
    func sendInvite(other: String, date: String, completion: @escaping (Bool) -> Void) {
        let curTime = fullDateFommatter.string(from: Date())
        let user = UserInfo.shared.getUserIdx()
        let msg = "동행 신청 메시지입니다.-\(date)"
        let createChatInfo: Dictionary<String, Any> = [
            "date": curTime,
            "msg": msg,
            "type": 2,
            "userIdx": user
            ]
        ref.child("conversations").child("\(user)_\(other)").childByAutoId().setValue(createChatInfo)
        let createRoomInfo: Dictionary<String, Any> = [
            "boardIdx": 0,
            "lastMessage": msg,
            "lastTime": curTime,
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
}
