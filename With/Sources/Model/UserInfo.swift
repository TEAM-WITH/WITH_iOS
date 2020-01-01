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
    
    private var token: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4Ijo4MSwibmFtZSI6IuqwleuvvOyerCIsImdlbmRlciI6LTEsImlhdCI6MTU3NzkxMDAyMCwiZXhwIjoxNTc3OTk2NDIwLCJpc3MiOiJ3aXRoRGV2In0.MCZEqmRWAVkUDOEKmSq5UT97RaJUWybOjPe7FMFJ_oc"
    private var userIdx: Int = 14
    
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
