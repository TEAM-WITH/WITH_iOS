//
//  ChatModel.swift
//  With
//
//  Created by 남수김 on 2019/12/30.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
struct ChatModel {
    var date: String
    var msg: String
    var type: Int
    var userIdx: Int
}

struct Chat {
    var type: ChatType
    var userIdx: Int
    var nickName: String?
    var message: String?
    var date: String? 
    var hide: Bool = false
    var meetDate: String?
}

struct ChatList {
    var boardIdx: Int
    var lastMsg: String
    var unSeenCount: Int
    var time: String
    var roomId: String
}

enum ChatType: Int {
    case mine = 0
    case other = 1
    case myInvite = 2
    case otherInvite = 3
    case otherComplete = 4
    case otherProfile = 5
    case date = 6
}
