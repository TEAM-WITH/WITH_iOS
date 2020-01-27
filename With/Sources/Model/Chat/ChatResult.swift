//
//  ChatResult.swift
//  With
//
//  Created by 남수김 on 2020/01/03.
//  Copyright © 2020 ns. All rights reserved.
//

import Foundation
struct ChatListResult: Codable {
    var userIdx: Int
    var boardIdx: Int
    var roomId: String
    var userImg: String
    var name: String
    var regionName: String?
    var title: String
    var withDate: String?
    var startDate: String
    var endDate: String
    var withFlag: Int?
    var evalFlag: Int?
    var writerImg: String
    var regionImgE: String?
}
