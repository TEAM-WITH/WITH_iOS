//
//  BaseAPI.swift
//  With
//
//  Created by 남수김 on 2019/12/24.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation

struct BaseAPI {
    static let baseURL = "http://18.222.189.150:3000"
    static let homeURL = baseURL+"/home"
    static let socketURL = ""
    static let signUpURL = baseURL+"/auth/signup"
    static let logInURL = baseURL+"/auth/signin"
    static let regionCodeURL = baseURL+"/home/regions/"
    static let recentBoardURL = baseURL+"/home/boards/"
    static let recommendBoardURL = baseURL+"/home/recommendations"
    static let withMateURL = baseURL+"/home/mates"
    static let boardListURL = baseURL+"/board/region"
    static let myPageURL = baseURL+"/mypage"
    static let boardDetailURL = baseURL+"/board"
    static let homeImgURL = homeURL+"/bgImg"
    static let chatListURL = baseURL+"/chat"
    static let homeRecommendURL = homeURL+"/recommendations"
    static let homeRecentURL = homeURL+"/boards"
    
}
