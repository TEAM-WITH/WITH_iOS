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
    private var userIdx: Int = -1
    
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
    
    func setDefaultRegion(regionCode: String, regionName: String) {
        UserDefaults.standard.set(regionCode, forKey: "regionCode")
        UserDefaults.standard.set(regionName, forKey: "regionName")
    }
    
    func isNotDefaultRegion() -> Bool {
        return nil == UserDefaults.standard.value(forKey: "regionCode")
    }
}
