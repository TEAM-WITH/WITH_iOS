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
    static let socketURL = ""
    static let signUpURL = "/auth/signup"
    static let regionCodeURL = baseURL+"/home/regions/"
    static let recentBoardURL = baseURL+"/home/boards/"
    static let recommendBoardURL = baseURL+"/home/recommendations"
    static let withMateURL = baseURL+"/home/mates"
}
