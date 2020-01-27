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
/*
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
            }
        }
    }
}
*/
