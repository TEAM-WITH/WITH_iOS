//
//  BoardDetailResult.swift
//  With
//
//  Created by 남수김 on 2020/01/02.
//  Copyright © 2020 ns. All rights reserved.
//

import Foundation
struct BoardDetail: Codable {
    var boardIdx: Int
    var regionName: String
    var title: String
    var content: String
    var startDate: String
    var endDate: String
    var active: Int
    var filter: Int
    var userIdx: Int
    var name: String
    var birth: Int
    var gender: Int
    var userImg: String
    var intro: String?
    var withFlag: Int?
    var badge: Int
}
