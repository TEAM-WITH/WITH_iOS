//
//  ServiceTestViewController.swift
//  With
//
//  Created by 남수김 on 2019/12/29.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import Firebase
class ServiceTestViewController: UIViewController {
    var user1: SignUpModel!
    var ref: DatabaseReference!
    var unSeenCount = 0
    let fullDateFommatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 hh:mm"
        return formatter
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFommatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko")
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
        
//        guard var birth = dateFommatter.date(from: "1996-02-10") else { return }
//        birth.addTimeInterval(60*60*24)
        user1 = SignUpModel(userId: "nsns", password: "123", name: "남수", birth: "1996-02-10", gender: -1)
        
        setFirebase()
        firebaseEventObserver()
        
    }
    
    @IBAction func sendRequest(_ sender: Any) {
//        UserService.shared.postSignUpRequest(userData: user1) { data in
//            print(data)
//        }
        chat(user1: "aa", user2: "bb", msg: "hi")
        
    }
    
}

extension ServiceTestViewController {
    
    
    func setFirebase() {
        
        self.ref = Database.database().reference()
        self.ref.child("conversations")
        
    }
    
    func firebaseEventObserver() {
        self.ref.observe(.value) { (snapshot) in
//            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
//            print(postDict)
            
            for item in snapshot.children.allObjects as! [DataSnapshot] {
                if let chatRoomic = item.value as? [String: AnyObject] {
                    print("***chatRoomic: \(item.key)")
                    let list = chatRoomic.keys // 채팅목록 불러오기
                    print("***list: \(list)")

                }
            }
        }
    }
    
    func chat(user1: String, user2: String, msg: String) {
        let time = fullDateFommatter.string(from: Date())
        let createChatInfo: Dictionary<String, Any> = [
            "date": time,
            "msg": "테스트메시지`",
            "type": 0,
            "userIdx": 1
            ]
        ref.child("conversations").child("\(user1)_\(user2)").childByAutoId().setValue(createChatInfo) { (err, ref) in
            if err == nil {
                
            }
        }
        
        
        let createRoomInfo: Dictionary<String, Any> = [
            "boardIdx": 0,
            "lastMessage": msg,
            "lastTime": time,
            "unSeenCount": 0
        ]
        ref.child("users").child("\(user1)").child("\(user1)_\(user2)").setValue(createRoomInfo)
        ref.child("users").child("\(user2)").child("\(user1)_\(user2)").setValue(createRoomInfo)
        
        
    }
}
