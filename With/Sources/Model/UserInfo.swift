//
//  UserInfo.swift
//  With
//
//  Created by 남수김 on 2019/12/31.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
class UserInfo {
    private init() {}
    static let shared = UserInfo()
    
    private var token: String = ""
    private var userIdx: Int = 12
    
    func setUserInfo(token: String, userIdx: Int) {
        self.token = token
        self.userIdx = userIdx
    }
    
    func getUserIdx() -> Int {
        return self.userIdx
    }
    
    func getUserToken() -> String {
        return self.token
    }
}
