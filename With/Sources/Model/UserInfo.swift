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
    
    private var token: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4Ijo4MSwibmFtZSI6IuqwleuvvOyerCIsImdlbmRlciI6LTEsImlhdCI6MTU3Nzk2MDEwNywiZXhwIjoxNTc4MDQ2NTA3LCJpc3MiOiJ3aXRoRGV2In0.UexfeVArrFqHqkls2y5YGzXffuzMtYTpriN7JeiV9oY"
    private var userIdx: Int = 81//14
    
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
